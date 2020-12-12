//
//  Resource.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import Foundation

enum Result<Value> {
    case success(Value?)
    case failure(Error)
}

enum HttpMethod<Body> {
    case get
    case post(Body?)
    case delete
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        }
    }
}

struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> A?
    let parseError: (Data) -> Error?
}

extension Resource {
    func map<B>(_ transform: @escaping (A) -> B) -> Resource<B> {
        return Resource<B>(urlRequest: urlRequest, parse: { data -> B? in
            self.parse(data).map(transform)
        }, parseError: { data -> Error? in
            do {
                let responseObject = try JSONDecoder().decode(BadError.self, from: data)
                return responseObject
            } catch {
            }
            return nil
        })
    }
}

extension Resource where A: Decodable {
    init<Body: Encodable>(url: URL, method: HttpMethod<Body>, param: [String: String]? = nil, headers: [String: String]? = [:]) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        switch method {
        case .get: ()
        case let .post(body):
            if let param = param {
                urlRequest.encodeParameters(parameters: param)
            } else if let body = body {
                do {
                    urlRequest.httpBody = try JSONEncoder().encode(body)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        case .delete: ()
        }

        parse = { data in
            do {
                return try JSONDecoder().decode(A.self, from: data)
            } catch let parsingError {
                print("Error", parsingError)
            }

            return nil
        }

        parseError = { data in
            try? JSONDecoder().decode(BadError.self, from: data)
        }
    }
}

struct BadError: Error, Codable {
    var message: String
    var messageCode: Int
}

struct ErrorContent: Codable {
    let messages: String
    let type: String

    private enum CodingKeys: String, CodingKey {
        case messages, type
    }
}

extension URLSession {
    func load<A>(_ resource: Resource<A>, completion: @escaping (Result<A>) -> Void) {
        dataTask(with: resource.urlRequest) { data, response, error in
            DispatchQueue.main.async {
                let statusCode = (response as? HTTPURLResponse)?.statusCode

                if let error = error {
                    let error = BadError(message: error.localizedDescription, messageCode: 2)
                    completion(Result.failure(error))

                    return
                }

                switch statusCode {
                case _ where statusCode! == 200 || statusCode! == 204:
                    guard let data = data else { return }

                    guard let parsedResponse = resource.parse(data) else {
                        let error = BadError(message: "Error", messageCode: 1)
                        completion(Result.failure(error))

                        return
                    }

                    let responseData: Result<A> = Result<A>.success(parsedResponse)
                    completion(responseData)

                case 401:
                    let error = BadError(message: "Error", messageCode: 3)
                    completion(Result.failure(error))
                default:
                    guard let data = data, let parsedResponse = resource.parseError(data) else {
                        let error = BadError(message: "Error", messageCode: 2)
                        completion(Result.failure(error))
                        return
                    }

                    let responseData = Result<A>.failure(parsedResponse)
                    completion(responseData)
                }
            }
        }.resume()
    }
}

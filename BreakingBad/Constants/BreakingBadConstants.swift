//
//  BreakingBadConstants.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import Foundation


struct BreakingBadURL {
    static var scheme: String { return "https" }
    static var pathExtension: String { return "api" }
}

struct BreakingBadURLConstant {
    static var host: String { return "breakingbadapi.com" }
}

struct BreakingBadConstant {
    static let cellRowHeight = 50
}
enum BreakingBadEndpoint {
    case charectors
    case other

    var urlComponents: URLComponents {
        var urlComponents = URLComponents()

        urlComponents.scheme = BreakingBadURL.scheme
        urlComponents.host = host
        urlComponents.path = BreakingBadURL.pathExtension + pathComponent

        return urlComponents
    }

    fileprivate var host: String? {
        return BreakingBadURLConstant.host
    }

    fileprivate var pathComponent: String {
        var path = ""

        switch self {
        case .charectors:
            path = "/charectors"
        default:
            return ""
        }

        return path
    }
}

enum BreakingBadQueryOptions {
    case action(String)
    case id(String)
   

    var queryItems: [URLQueryItem] {
        switch self {
        case let .action(action):
            return [URLQueryItem(name: "action", value: action)]
        case let .id(id):
            return [URLQueryItem(name: "id", value: id)]
        }
    }
}

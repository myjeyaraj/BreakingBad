//
//  Request.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import Foundation

struct Request {
    static func breakingBadCharectors(completion: @escaping ((Result<[BreakingBadUser]>) -> Void)) {
        let urlComponents = BreakingBadEndpoint.characters.urlComponents
        guard let url = urlComponents.url else { return }

        let resource = Resource<[BreakingBadUser]>(url: url, method: HttpMethod<[BreakingBadUser]>.get, headers: RequestHeader.header)
        URLSession.shared.load(resource) { completion($0) }
    }
}

extension Request {
    struct RequestHeader {
        static let header = ["Content-Type": "application/json; charset=utf-8", "Accept": "application/json"]
    }
}

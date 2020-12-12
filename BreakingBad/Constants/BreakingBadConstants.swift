//
//  BreakingBadConstants.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit


struct BreakingBadURL {
    static var scheme: String { return "https" }
    static var pathExtension: String { return "/api" }
}

struct BreakingBadURLConstant {
    static var host: String { return "breakingbadapi.com" }
}

struct BreakingBadConstant {
    static let cellRowHeight = 50
}
enum BreakingBadEndpoint {
    case characters
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
        case .characters:
            path = "/characters"
        default:
            return ""
        }

        return path
    }
}
 

struct Constants {
struct View {
    static let cornerRadius: CGFloat = 4.0
    static let shadowRadius: CGFloat = 2.0
    static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let shadowOpacity: Float = 0.1
}
}

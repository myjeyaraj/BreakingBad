//
//  BreakingBadCharector.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import Foundation

struct BreakingBadUser: Codable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let imageURL: String
    let status: String
    let nickname: String
    let appearance: [Int]?
    let portrayed: String
    let category: String
    let bettercallAappearance: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageURL = "img"
        case status
        case nickname
        case appearance
        case portrayed
        case category
        case bettercallAappearance = "better_call_saul_appearance"
        
    }
}

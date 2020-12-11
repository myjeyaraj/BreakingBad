//
//  BreakingBadCharector.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import Foundation

struct BreakingBadUser: Codable {
    let id: String
    let name: String
    let birthday: String
    let occupation: [String]
    let imageURL: String
    let status: String
    let nickName: String
    let appearence: [Int]
    let portrayed: String
    let category: String
    let bettercallAappearance: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageURL = "img"
        case status
        case nickName
        case appearence
        case portrayed
        case category
        case bettercallAappearance = "better_call_saul_appearance"
        
    }

}


struct Occupation: Codable {
    
}

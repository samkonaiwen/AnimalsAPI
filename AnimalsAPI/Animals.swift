//
//  Animals.swift
//  AnimalsAPI
//
//  Created by SAM on 2020/11/2.
//

import Foundation
import UIKit


struct Animals: Codable {
    let id: Int
    let file_name: String!
    let name: NameData
    let birthday_string: String!
    let gender: String!
    let subtype: String!
    let species: String!
    let hobby: String!
    let image_uri: String!
    
    enum CodingKeys: String, CodingKey {
        case id
        case file_name = "file-name"
        case name
        case birthday_string = "birthday-string"
        case gender
        case subtype
        case species
        case hobby
        case image_uri
    }
}

struct NameData: Codable {
    let name_TWzh: String!
    
    enum CodingKeys: String, CodingKey {
        case name_TWzh = "name-TWzh"
    }
}

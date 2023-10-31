//
//  model.swift
//  lec8demo
//
//  Created by Andy Huang on 10/26/23.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String?
    let age: Int
    let graduated: Bool

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case age
        case graduated
    }
}

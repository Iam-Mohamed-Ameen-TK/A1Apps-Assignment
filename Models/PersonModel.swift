//
//  UserModel.swift
//  A1Apps Assignment
//
//  Created by Mohamed Ameen on 20/09/25.
//

import Foundation

struct Person: Codable, Identifiable {
    let image: String
    let email: String
    let name: String
    let age: Int
    let dob: String
    
    var id: String {
        email
    }
    
    enum CodingKeys: String, CodingKey {
        case image, email, name, age, dob
    }
}

struct APIResponse: Codable {
    let data: [Person]
}

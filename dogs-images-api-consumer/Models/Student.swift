//
//  Student.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 04/11/23.
//

import Foundation

struct Student {
    
    let name: String
    let id: Int
    let email: String
    let phone: String
    let bio: String
    
    init(name: String, id: Int, email: String, phone: String, bio: String) {
        self.name = name
        self.id = id
        self.email = email
        self.phone = phone
        self.bio = bio
    }
}

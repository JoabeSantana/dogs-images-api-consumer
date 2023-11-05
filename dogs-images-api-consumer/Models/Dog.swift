//
//  Dog.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import Foundation

struct Dog: Codable {
    
    let id: String
    let url: String
    let breed: Breed?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case breed = "breeds"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        let dogBreed = try container.decode([Breed].self, forKey: .breed)
        self.breed = dogBreed.first
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.url, forKey: .url)
    }
}

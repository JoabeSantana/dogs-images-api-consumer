//
//  Breed.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import Foundation

struct Breed : Codable {
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperament: String?
    let weight: Weight
    let height: Height
    
    enum CodingKeys: String, CodingKey {
        case name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case weight
        case height
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.bredFor = try container.decodeIfPresent(String.self, forKey: .bredFor)
        self.breedGroup = try container.decodeIfPresent(String.self, forKey: .breedGroup)
        self.lifeSpan = try container.decodeIfPresent(String.self, forKey: .lifeSpan)
        self.temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
        self.weight = try container.decode(Weight.self, forKey: .weight)
        self.height = try container.decode(Height.self, forKey: .height)
    }
}

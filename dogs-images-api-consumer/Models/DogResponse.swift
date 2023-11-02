//
//  DogResponse.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import Foundation

struct DogResponse: Decodable {
    let results: [Dog]

    enum CodingKeys: CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.results = try container.decode([Dog].self)
    }
}

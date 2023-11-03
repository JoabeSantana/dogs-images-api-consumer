//
//  Height.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import Foundation

struct Height: Codable {
    
    let imperial: String
    let metric: String
    
    enum CodingKeys: CodingKey {
        case imperial
        case metric
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imperial = try container.decode(String.self, forKey: .imperial)
        self.metric = try container.decode(String.self, forKey: .metric)
    }
}

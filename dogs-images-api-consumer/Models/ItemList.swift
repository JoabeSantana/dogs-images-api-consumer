//
//  ItemList.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 04/11/23.
//

import Foundation

struct ItemList {
    
    let identifier: String
    let description: String
    
    init(identifier: String, description: String) {
        self.identifier = identifier
        self.description = description
    }
}

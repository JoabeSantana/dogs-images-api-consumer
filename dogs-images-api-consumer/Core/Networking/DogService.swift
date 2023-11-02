//
//  DogService.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import Foundation

enum DogServiceError: Error {
    case invalidURL
    case couldNotReturnDogList(errorCode: Int)
    case couldNotDecodeObject
    case couldNotGetError
}

class DogService {
    
    func fetchDogList(sizeList: Int = 1) async throws -> [Dog] {
        let urlString = "https://api.thedogapi.com/v1/images/search?size=thumb&has_breeds=true&limit=\(sizeList)"

        guard let url = URL(string: urlString) else {
            throw DogServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-api-key": "live_dmpsGnerefTPjX2XGbKpxZ4zzHdefPoDZ5HPdoKi0qiQ5JtUfLtf6Py2xCCs4yxA"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let jsonDogData = """
                [
                    {
                            "breeds": [
                                {
                                    "weight": {
                                        "imperial": "45 - 55",
                                        "metric": "20 - 25"
                                    },
                                    "height": {
                                        "imperial": "20 - 22",
                                        "metric": "51 - 56"
                                    },
                                    "id": 32,
                                    "name": "Bearded Collie",
                                    "bred_for": "Sheep herding",
                                    "breed_group": "Herding",
                                    "life_span": "12 - 14 years",
                                    "temperament": "Self-confidence, Hardy, Lively, Alert, Intelligent, Active",
                                    "reference_image_id": "A09F4c1qP"
                                }
                            ],
                            "id": "yxsOLj-GU",
                            "url": "https://cdn2.thedogapi.com/images/yxsOLj-GU.jpg",
                            "width": 1080,
                            "height": 1319
                        }
                ]
            """
            //let response = try JSONDecoder().decode(DogResponse.self, from: jsonDogData.data(using: .utf8)!)
            let response = try JSONDecoder().decode(DogResponse.self, from: data)
            return response.results
        } catch {
            print(error)
            if let urlError = error as? URLError {
                throw DogServiceError.couldNotReturnDogList(errorCode: urlError.errorCode)
            } else if let _ = error as? DecodingError {
                throw DogServiceError.couldNotDecodeObject
            } else {
                throw DogServiceError.couldNotGetError
            }
        }
    }
}

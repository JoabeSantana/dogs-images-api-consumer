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
    
    func fetchDogList(sizeList: Int = 10) async throws -> [Dog] {
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
                        "id": "33mJ-V3RX",
                        "url": "https://cdn2.thedogapi.com/images/33mJ-V3RX.jpg",
                        "breeds": [
                            {
                                "weight": {
                                    "imperial": "55 - 90",
                                    "metric": "25 - 41"
                                },
                                "height": {
                                    "imperial": "18 - 24",
                                    "metric": "46 - 61"
                                },
                                "id": 7,
                                "name": "Alapaha Blue Blood Bulldog",
                                "description": "The Alapaha Blue Blood Bulldog is a well-developed, exaggerated bulldog with a broad head and natural drop ears. The prominent muzzle is covered by loose upper lips. The prominent eyes are set well apart. The Alapaha's coat is relatively short and fairly stiff. Preferred colors are blue merle, brown merle, or red merle all trimmed in white or chocolate and white. Also preferred are the glass eyes (blue) or marble eyes (brown and blue mixed in a single eye). The ears and tail are never trimmed or docked. The body is sturdy and very muscular. The well-muscled hips are narrower than the chest. The straight back is as long as the dog is high at the shoulders. The dewclaws are never removed and the feet are cat-like.",
                                "bred_for": "Guarding",
                                "breed_group": "Mixed",
                                "life_span": "12 - 13 years",
                                "history": "",
                                "temperament": "Loving, Protective, Trainable, Dutiful, Responsible",
                                "reference_image_id": "33mJ-V3RX"
                            }
                        ],
                        "width": 1828,
                        "height": 2065
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

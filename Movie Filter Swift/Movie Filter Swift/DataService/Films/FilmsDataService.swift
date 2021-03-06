//
//  FilmsDataService.swift
//  Movie Filter Swift
//
//  Created by Timothy Kosakoy on 14/03/21.
//  Copyright © 2021 Re:Utopia. All rights reserved.
//

import Foundation

enum FilmsDataService {
    enum Endpoint {
        case all
        
        var value : String {
            switch self {
            case .all: return "/films"
            }
        }
    }
    
    struct Get {
        static func allGhibliFilms(
            for vm: ViewModelProtocol,
            completion: @escaping (APIResults<[GhibliFilm]>?, APIError<[String]>?, ViewModelProtocol) -> ()
        ) {
            Network().fetch(
                requestURL: URL(string: Network.BaseURL.GHIBLI_API.value + Endpoint.all.value)!,
                requestType: .GET
            ) { result in
                switch result {
                case .SUCCESS(let res):
                    do {
                        let data = try JSONDecoder().decode(APIResults<[GhibliFilm]>.self, from: res as! Data)
                        completion(data, nil, vm)
                    } catch {
                        completion(nil, APIError<[String]>(errors: ["Error while decoding"]), vm)
                    }
                case .FAILURE(let err):
                    do {
                        let data = try JSONDecoder().decode(APIError<[String]>.self, from: err as! Data)
                        completion(nil, data, vm)
                    } catch {
                        completion(nil, APIError<[String]>(errors: ["Error while decoding"]), vm)
                    }
                }
                
            }
        }
    }
}

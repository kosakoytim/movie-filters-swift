//
//  API.swift
//  Movie Filter Swift
//
//  Created by Timothy Kosakoy on 14/03/21.
//  Copyright © 2021 Re:Utopia. All rights reserved.
//

import Foundation

protocol APIProtocol {}

struct APIResults<T : Decodable> : Decodable, APIProtocol {
    let results : T
}

struct APIError<T :Decodable> : Decodable, APIProtocol {
    var errors : T
}

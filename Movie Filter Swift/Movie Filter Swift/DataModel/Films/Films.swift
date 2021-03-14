//
//  Films.swift
//  Movie Filter Swift
//
//  Created by Timothy Kosakoy on 14/03/21.
//  Copyright © 2021 Re:Utopia. All rights reserved.
//

import Foundation

protocol Films {
    var id : String { get set }
    var title: String { get set }
    var description: String { get set }
    var director: String { get set }
    var release_date: String { get set }
}

struct GhibliFilm : Films, Decodable {
    var id: String
    var title: String
    var description: String
    var director: String
    var release_date: String
}

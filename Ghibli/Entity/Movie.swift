//
//  Movie.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import Foundation

struct Movie : Decodable {
    let id: String
    let title: String
    let description: String
    let director: String
    let releaseYear: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case director
        case releaseYear = "release_date"
    }
}

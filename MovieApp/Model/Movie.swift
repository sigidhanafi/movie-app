//
//  Movie.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 24/06/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let image: String
    
    init(id: String, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
}

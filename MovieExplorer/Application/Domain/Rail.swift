//
//  Rail.swift
//  MovieExplorer
//
//  Created by João Pedro on 14/02/2022.
//

import Foundation

struct Rail: Hashable {
    
    var identifier = UUID()
    var name: String
    var movies: [Movie]
    
    init(name: String, movies: [Movie]) {
        self.name = name
        self.movies = movies
    }
}

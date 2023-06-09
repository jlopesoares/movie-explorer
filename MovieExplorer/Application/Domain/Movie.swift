//
//  Movie.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/02/2022.
//

import Foundation
import TMDb

struct Movie: Codable, Hashable, ImageUseCase {
    
    let id: Int
    let title: String
    let posterURL: URL?
    let backdropURL: URL?
    let overview: String?
    let releaseDate: Date?
    let voteAverage: Double?
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(movie: TMDb.Movie) {
        id = movie.id
        title = movie.title
        posterURL = movie.posterPath
        backdropURL = movie.backdropPath
        overview = movie.overview
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
    }
    
    var getBackdropURL: URL? {
        getImageUrl(for: backdropURL?.absoluteString, with: .small)
    }
}

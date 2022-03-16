//
//  Movie.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/02/2022.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

public struct Movie: Codable, Hashable, ImageUseCase {
    
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let tagline: String?
    public let adult: Bool
    public let runtime: Int?
   
    public var posterURL: URL? {
        getImageUrl(for: posterPath, with: .small)
    }
    
    public var backdropURL: URL? {
        getImageUrl(for: backdropPath, with: .medium)
    }
    
    public var backdropOriginalURL: URL? {
        getImageUrl(for: backdropPath, with: .big)
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage * 10))%"
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Movie {
    
    struct Diffable: Hashable {
        
        let id = UUID()
        let movieIdentifier: Int
        let title: String
        let overview: String
        let imageURL: URL?
        
        init(movie: Movie) {
            movieIdentifier = movie.id
            title = movie.title
            overview = movie.overview
            imageURL = movie.backdropURL
        }
    }
}

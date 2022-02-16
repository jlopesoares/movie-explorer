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

public struct Movie: Codable, Hashable {
    
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
   
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
//    public var backdropURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
//    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath ?? "")")!
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

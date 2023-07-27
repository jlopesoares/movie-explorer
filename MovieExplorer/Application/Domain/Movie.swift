//
//  Movie.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/02/2022.
//

import Foundation
import TMDb

struct Movie: Codable, Hashable, ImageUseCase {
    
    let id = UUID()
    let movieID: Int
    let title: String
    let posterURL: URL?
    let backdropURL: URL?
    let overview: String?
    let releaseDate: Date?
    let voteAverage: String?
    let duration: Int?
    let metadata: String?
    let overView: String?
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(movie: TMDb.Movie) {
        movieID = movie.id
        title = movie.title
        posterURL = movie.posterPath
        backdropURL = movie.backdropPath
        overview = movie.overview
        releaseDate = movie.releaseDate
        voteAverage = String(format: "%.2f", movie.voteAverage ?? "")
        duration = movie.runtime
        metadata = Movie.getMetadata(from: movie)
        overView = movie.overview
    }
    
    var getBackdropURL: URL? {
        getImageUrl(for: backdropURL?.absoluteString, with: .small)
    }
    
    func getPosterURL(size: ImageSize) -> URL? {
        getImageUrl(for: posterURL?.absoluteString, with: size)
    }
    
    static func getMetadata(from movie: TMDb.Movie) -> String {
        let separator = " • "
        var metadata = ""
        
        //Add Genre
        if let mainGenre = movie.genres?.first?.name {
            metadata.append(metadata.isEmpty ? mainGenre : separator + mainGenre)
        }
        
        //Add Duration
        if let duration = movie.runtime {
            metadata.append(metadata.isEmpty ? "\(duration)min" : separator + "\(duration)min")
        }
        
        //Add year
        if let releaseDate = movie.releaseDate {
            let calendar = Calendar.current
            let yearComponent = calendar.component(.year, from: releaseDate)
            
            metadata.append(metadata.isEmpty ? "\(yearComponent)" : separator + "\(yearComponent)")
        }
        
        return metadata
    }
}

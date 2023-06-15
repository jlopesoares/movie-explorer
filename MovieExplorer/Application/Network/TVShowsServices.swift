//
//  TVShowsServices.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import Foundation
import TMDb

protocol TVShowsServiceProtocol {
    func fetchPopularTVShows() async throws -> [TVShow]
}

class TVShowsService: TVShowsServiceProtocol {
    
    private let tmdbServices: TMDBServices
    
    init(tmdbServices: TMDBServices){
        self.tmdbServices = tmdbServices
    }
    
    func fetchPopularTVShows() async throws -> [TVShow] {
        try await tmdbServices.tmdb.tvShows.popular(page: 1).results.map{ .init(tvShow: $0) } 
    }
}

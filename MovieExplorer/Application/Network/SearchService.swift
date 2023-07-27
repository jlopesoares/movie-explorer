//
//  SearchService.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 27/07/2023.
//

import Foundation

protocol SearchServiceProtocol {
    func fetchContent(for term: String) async throws -> [Movie]
}

class SearchService: SearchServiceProtocol {
    
    private let tmdbServices: TMDBServices
    
    init(tmdbServices: TMDBServices){
        self.tmdbServices = tmdbServices
    }
    
    func fetchContent(for term: String) async throws -> [Movie] {
        try await tmdbServices.tmdb.search.searchMovies(query: term, year: nil, page: nil).results.map({.init(movie: $0)})
    }
}


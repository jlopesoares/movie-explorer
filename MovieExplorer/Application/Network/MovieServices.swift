//
//  MovieServices.swift
//  MovieExplorer
//
//  Created by João Pedro on 14/02/2022.
//

import Foundation
import TMDb

typealias MovieDetailCompletion = (Result<Movie, Error>) -> ()
typealias MovieCastCompletion = (Result<[Cast], Error>) -> ()


protocol MovieServiceProtocol {
    func fetchPopularMovies() async -> [Movie]
    func fetchUpcomingMovies() async -> [Movie]
    func fetchNowPlayingMovies() async -> [Movie]
    func fetchMovieProviders() async -> [MovieProvider]
}

class MovieService: MovieServiceProtocol {

    private let tmdbServices: TMDBServices
    
    init(tmdbServices: TMDBServices){
        self.tmdbServices = tmdbServices
    }
    
    func fetchPopularMovies() async -> [Movie] {
        do {
            return try await tmdbServices.tmdb.movies.popular(page: 0).results.map({.init(movie: $0)})
        } catch {
            return []
        }
    }
    
    func fetchUpcomingMovies() async -> [Movie] {
        do {
            return try await tmdbServices.tmdb.movies.upcoming(page: 0).results.map({.init(movie: $0)})
        } catch {
            return []
        }
    }
    
    func fetchNowPlayingMovies() async -> [Movie] {
        do {
            return try await tmdbServices.tmdb.movies.nowPlaying(page: 0).results.map({.init(movie: $0)})
        } catch {
            return []
        }
    }
    
    
    func fetchMovieProviders() async -> [MovieProvider] {
        do {
            return try await tmdbServices.tmdb.watchProviders.movieWatchProviders().map({.init(watchProvider: $0)})
        } catch {
            return []
        }
    }
    
    func details(id: Int) async throws -> Movie {
        try await Movie(movie: tmdbServices.tmdb.movies.details(forMovie: id))
    }
}


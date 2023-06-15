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
    func fetchCast(for movieId: Int) async throws -> [Cast]
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
        let movieDetails = try await tmdbServices.tmdb.movies.details(forMovie: id)
        return Movie(movie: movieDetails)
    }
    
    func fetchCast(for movieId: Int) async throws -> [Cast] {
        return try await tmdbServices.tmdb.movies.credits(forMovie: movieId).cast.map({.init(castMember: $0)})
    }
}


//
//  MovieServices.swift
//  MovieExplorer
//
//  Created by João Pedro on 14/02/2022.
//

import Foundation

typealias MovieDetailCompletion = (Result<Movie, Error>) -> ()
typealias MovieCastCompletion = (Result<[Cast], Error>) -> ()

protocol MovieServiceProtocol {
    func fetchMovies(with Endpoint: MovieEndpoints, success: @escaping (_ movie: MoviesResponse)-> Void, failure: @escaping (_ error: ErrorResponse)-> Void)
}

class MovieService: MovieServiceProtocol {
    
    init(){}
    static let shared = MovieService()
    private let apiKey = ""
    private let baseUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    func getMovieDetail(for identifier: String, completion: @escaping MovieDetailCompletion) {
        
        //create url components
        guard var urlComponents = URLComponents(string: "\(baseUrl)/movie/\(identifier)") else {
            return
        }
        
        //create query items
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        //generate valid url
        guard let url = urlComponents.url else {
            return
        }
        
        //perform network request
        urlSession.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let movieResponse = try self.jsonDecoder.decode(Movie.self, from: data)
                completion(.success(movieResponse))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func getMovieCast(for identifier: String, completion: @escaping MovieCastCompletion) {
        
        //create url components
        guard var urlComponents = URLComponents(string: "\(baseUrl)/movie/\(identifier)/credits") else {
            return
        }
        
        //create query items
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        //generate valid url
        guard let url = urlComponents.url else {
            return
        }
        
        //perform network request
        urlSession.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let cast = try self.jsonDecoder.decode(CastResponse.self, from: data)
                completion(.success(cast.cast))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    func fetchMovies(with Endpoint: MovieEndpoints, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        //create url components
        guard var urlComponents = URLComponents(string: "\(baseUrl)/movie/\(Endpoint.rawValue)") else {
            return failure(.invalidEndpoint)
        }
        
        //create query items
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        //generate valid url
        guard let url = urlComponents.url else {
            return failure(.invalidEndpoint)
        }
        
        //perform network request
        urlSession.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if error != nil {
                return failure(.apiError)
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return failure(.invalidResponse)
            }
            
            guard let data = data else {
                return failure(.noData)
            }
            
            do {
                let movieResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    success(movieResponse)
                }
            } catch {
                return failure(.serializationError)
            }
        }.resume()
    }
}

public enum MovieEndpoints: String, CustomStringConvertible {
    case popular
    case upcoming
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    
    public var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case.upcoming: return "Upcoming"
        }
    }
}

public enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Ooops, there is something problem with the api"
        case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
        case .invalidResponse: return "Ooops, there is something problem with the response"
        case .noData: return "Ooops, there is something problem with the data"
        case .serializationError: return "Ooops, there is something problem with the serialization process"
        }
    }
}

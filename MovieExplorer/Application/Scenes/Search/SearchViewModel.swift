//
//  SearchViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 27/07/2023.
//

import Foundation

final class SearchViewModel {
    
    let service: SearchService
    var datasource = [Rail]()
    
    init(service: SearchService) {
        self.service = service
    }
    
    func rail(for indexPath: IndexPath) -> Rail {
        datasource[indexPath.section]
    }
    
    func item(for indexPath: IndexPath) -> AnyHashable {
        switch rail(for: indexPath).type {
        case .providers(let providers):
            return providers[indexPath.row]
            
        case .movies(let movies):
            return movies[indexPath.row]
        }
    }
    
    func search(term: String) async {
        do {
            let searchedMovies = try await service.fetchContent(for: term)

            let rail = Rail(name: "Results", type: .movies(searchedMovies))
            self.datasource = [rail]
        } catch {
            print("something went wrong")
        }
    }
}

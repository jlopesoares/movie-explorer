//
//  ImageUseCase.swift
//  MovieExplorer
//
//  Created by João Pedro on 16/03/2022.
//

import Foundation

enum ImageSize: String {
    case small = "w500",
    medium = "w1280",
    big = "original"
}

protocol ImageUseCase {

    func getImageUrl(for path: String?, with size: ImageSize) -> URL? 
}

extension ImageUseCase {
    
    func getImageUrl(for path: String?, with size: ImageSize) -> URL? {
        
        guard let path = path else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(path)")
    }
}

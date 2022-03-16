//
//  Cast.swift
//  MovieExplorer
//
//  Created by João Pedro on 24/02/2022.
//

import Foundation

public struct CastResponse: Codable {
    public let id: Int
    public let cast: [Cast]
}

public struct Cast: Codable, Hashable, ImageUseCase {
    
    let id: Int
    let name: String
    let profilePath: String?
    
    public var profileImageURL: URL? {
        getImageUrl(for: profilePath, with: .medium)
    }
    
}

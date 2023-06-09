//
//  Rail.swift
//  MovieExplorer
//
//  Created by João Pedro on 14/02/2022.
//

import Foundation

enum RailType: Hashable {
    static func == (lhs: RailType, rhs: RailType) -> Bool {
        switch (lhs, rhs) {
        case (.movies, .movies), (.providers, .providers):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        
        switch self {
        case .movies(let value):
            hasher.combine(value) // combine with associated value, if it's not `Hashable` map it to some `Hashable` type and then combine result
        case .providers(let value):
            hasher.combine(value) // combine with associated value, if it's not `Hashable` map it to some `Hashable` type and then combine result
        }
    }
    
    case movies([Movie]),
         providers([MovieProvider])
    
    var values: [AnyHashable] {
        switch self {
        case .movies(let movies):
            return movies
        case .providers(let providers):
            return providers
        }
    }
}

struct Rail: Hashable {
    static func == (lhs: Rail, rhs: Rail) -> Bool {
        lhs.identifier == rhs.identifier && rhs.type == rhs.type
    }
    
    var identifier = UUID()
    var name: String
    var type: RailType
    
    init(name: String, type: RailType) {
        self.name = name
        self.type = type
    }
}

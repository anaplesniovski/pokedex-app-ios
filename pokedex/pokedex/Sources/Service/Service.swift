//
//  Service.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 09/11/23.
//

import Foundation

enum Pokedex {
    case pokemon
    case pokemonDetails(name: String)
}

extension Pokedex: Route {
    
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .pokemon:
            return "/pokemon"
        case .pokemonDetails(let name):
            return "/pokemon/\(name)"
        }
    }
    
    var method: Method {
        return .GET
    }
}

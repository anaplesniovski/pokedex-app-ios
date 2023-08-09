//
//  PokemonData.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

struct PokemonData: Decodable {
    let pokemonList: [PokemonListData]
    
    enum CodingKeys: String, CodingKey {
        case pokemonList = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemonList = try container.decode([PokemonListData].self, forKey: .pokemonList)
    }
}

struct PokemonListData: Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

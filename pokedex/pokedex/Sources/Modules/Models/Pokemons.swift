//
//  PokemonData.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

struct Pokemons: Decodable {
    var results: [Pokemon]
}

struct Pokemon: Decodable {
    var name: String
    var url: String
}

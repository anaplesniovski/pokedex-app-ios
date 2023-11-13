//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 25/09/23.

import UIKit

class PokemonDetailsViewModel {
    
    private var pokemonDetails: PokemonDetails
    
    init(pokemonDetails: PokemonDetails) {
        self.pokemonDetails = pokemonDetails
    }
    
    var haveMoreOneType: Bool {
        return pokemonDetails.types.count > 1
    }
    
    var name: String {
        return pokemonDetails.name.capitalized
    }
    
    var types: String {
        return pokemonDetails.types.map { $0.type.name.capitalized }.joined(separator: " / ")
    }
    
    var id: String {
        return String(pokemonDetails.id)
    }
}

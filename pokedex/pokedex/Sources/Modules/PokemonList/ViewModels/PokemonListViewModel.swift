//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import Foundation

class PokemonListViewModel {
    private let pokemonService: PokemonServiceProtocol
    var pokemons: [Pokemon] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func loadPokemonList() {
        PokemonService.shared.getListPokemonDetails { [weak self] pokemonDetails in
            self?.pokemons = pokemonDetails
//            DispatchQueue.main.async {
//                self?.re
//            }
        }
    }
}

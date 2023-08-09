//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func updatePokemonList()
}

class PokemonListViewModel {
    
    private var pokemons: [Pokemon] = []
    weak var delegate: PokemonListViewModelDelegate?
    
    var filterPokemon: [Pokemon] = [] {
        didSet {
            delegate?.updatePokemonList()
        }
    }
    
    func loadPokemonList() {
        PokemonService.shared.getListPokemonDetails { [weak self] pokemonDetails in
            self?.pokemons = pokemonDetails
            self?.filterPokemon = pokemonDetails
        }
    }
    
    func filterPokemons(with searchText: String) {
        if searchText.isEmpty {
            filterPokemon = pokemons
        } else {
            let updatePokemonList = pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
                String($0.id).contains(searchText) }
            filterPokemon = updatePokemonList
        }
        delegate?.updatePokemonList()
    }
}


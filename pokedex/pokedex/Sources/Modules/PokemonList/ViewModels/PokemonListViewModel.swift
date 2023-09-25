//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject {
    func updatePokemonList()
}

class PokemonListViewModel: PokemonListViewModelProtocol {
    
    private let pokemonService: PokemonServiceProtocol
    private let pokemonImageService: PokemonImageServiceProtocol
    private var pokemons: [Pokemon] = []
    
    weak var delegate: PokemonListViewModelDelegate?
    
    init(pokemonService: PokemonServiceProtocol, pokemonImageService: PokemonImageServiceProtocol) {
        self.pokemonService = pokemonService
        self.pokemonImageService = pokemonImageService
    }
    
    var filterPokemon: [Pokemon] = [] {
        didSet {
            delegate?.updatePokemonList()
        }
    }
    
    func loadPokemonList() {
        pokemonService.getListPokemonDetails { [weak self] pokemonDetails in
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
    
    func loadPokemonImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        pokemonImageService.fetchImagePokemon(from: imageURL) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to download image from URL: \(url). Error: \(error)")
                completion(nil)
            }
        }
    }
}


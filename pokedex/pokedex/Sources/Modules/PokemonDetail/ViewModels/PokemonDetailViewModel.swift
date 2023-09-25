//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 25/09/23.

import UIKit

class PokemonDetailViewModel: PokemonDetailViewModelProtocol {

    private let pokemonImageService: PokemonImageServiceProtocol
    
    init(pokemonImageService: PokemonImageServiceProtocol) {
        self.pokemonImageService = pokemonImageService
    }
    
    func loadPokemonImageDetail(from url: URL, completion: @escaping (UIImage?) -> Void) {
        pokemonImageService.fetchImagePokemon(from: url) { result in
            DispatchQueue.main.async {
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
    
    func handleImageLoadingError() {
        print("Failed to download image")
    }
}

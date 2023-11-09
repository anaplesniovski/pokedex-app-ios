//
//  PokemonRequest.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.

import UIKit

class PokemonService: PokemonServiceProtocol {
    
    static let shared = PokemonService()
    let pokemonImageService = PokemonImageService()
    
    func fetchPokemonList(completion: @escaping ([PokemonListData]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let responseData = data else { return }
            do {
                let pokemonList = try JSONDecoder().decode(PokemonData.self, from: responseData)
                completion(pokemonList.pokemonList)
            } catch let error {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchPokemonDetail(pokemon: PokemonListData, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        guard let pokemonURL = URL(string: pokemon.url) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])))
                return
            }
            
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetailsData.self, from: responseData)
                let imageUrlString = pokemonDetail.image.imagePositions.frontDefault.imageURLFront
                guard let imageUrl = URL(string: imageUrlString) else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])))
                    return
                }
                
                self.pokemonImageService.fetchImagePokemon(from: imageUrl) { result in
                    switch result {
                    case .success(_):
                        let types = pokemonDetail.types.map { $0.type.name }
                        let pokemon = Pokemon(name: pokemonDetail.name,
                                              types: types,
                                              height: pokemonDetail.height,
                                              weight: pokemonDetail.weight,
                                              image: imageUrlString,
                                              id: pokemonDetail.id)
                        completion(.success(pokemon))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getListPokemonDetails(completion: @escaping ([Pokemon]) -> ()) {
        
        let dispatchGroup = DispatchGroup()
        var pokemonDetails: [Pokemon] = []
        
        fetchPokemonList { pokemonList in
            for pokemon in pokemonList {
                dispatchGroup.enter()
                self.fetchPokemonDetail(pokemon: pokemon) { result in
                    switch result {
                    case .success(let pokemonDetail):
                        pokemonDetails.append(pokemonDetail)
                        dispatchGroup.leave()
                    case .failure(let error):
                        dispatchGroup.leave()
                        print("Failed to fetch pokemon detail: \(error)")
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(pokemonDetails)
            }
        }
    }
}

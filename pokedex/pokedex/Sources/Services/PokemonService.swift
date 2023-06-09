//
//  PokemonRequest.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

class PokemonService {
        
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
    
    func fetchPokemonDetail(pokemon: PokemonListData, completion: @escaping (Pokemon) -> ()) {
        guard let pokemonURL = URL(string: pokemon.url) else { return }
        let task = URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
            guard let responseData = data else { return }
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetailsData.self, from: responseData)
                let image = pokemonDetail.image.imagePositions.frontDefault.imageURLFront
                let types = pokemonDetail.types.map { $0.type.name }
                let pokemon = Pokemon(name: pokemonDetail.name, types: types, height: pokemonDetail.height, weight: pokemonDetail.weight, image: image, id: pokemonDetail.id)
                completion(pokemon)
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getListPokemonDetails(completion: @escaping ([Pokemon]) -> ()) {
        var pokemonDetails: [Pokemon] = []
        let dispatchGroup = DispatchGroup()

        fetchPokemonList { pokemonList in
            for pokemon in pokemonList {
                dispatchGroup.enter()
                self.fetchPokemonDetail(pokemon: pokemon) { pokemonDetail in
                    let pokemonDetail = pokemonDetail
                    pokemonDetails.append(pokemonDetail)
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(pokemonDetails)
            }
        }
    }
}

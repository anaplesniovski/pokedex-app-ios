//
//  PokemonRequest.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

class PokemonRequest {
        
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
    
    func fetchPokemonDetail(pokemon: PokemonListData, completion: @escaping (PokemonDetailsData) -> ()) {
        guard let pokemonURL = URL(string: pokemon.url) else { return }
        let task = URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
            guard let responseData = data else { return }
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetailsData.self, from: responseData)
                completion(pokemonDetail)
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchPokemonDetailsData(completion: @escaping ([PokemonDetailsData]) -> ()) {
        var pokemonDetailsData: [PokemonDetailsData] = []
            var count = 0
        let dispatchGroup = DispatchGroup()
        
        fetchPokemonList { pokemonList in
            for pokemon in pokemonList {
                dispatchGroup.enter()
                self.fetchPokemonDetail(pokemon: pokemon) { pokemonDetail in
                    let pokemonDetail = pokemonDetail
                    pokemonDetailsData.append(pokemonDetail)
                    count += 1
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(pokemonDetailsData)
            }
        }
    }
}

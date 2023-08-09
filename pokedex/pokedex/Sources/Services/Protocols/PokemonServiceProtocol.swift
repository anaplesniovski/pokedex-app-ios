//
//  PokemonServiceProtocol.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(completion: @escaping ([PokemonListData]) -> ())
    func fetchPokemonDetail(pokemon: PokemonListData, completion: @escaping (Result<Pokemon, Error>) -> Void)
    func getListPokemonDetails(completion: @escaping ([Pokemon]) -> ())
}

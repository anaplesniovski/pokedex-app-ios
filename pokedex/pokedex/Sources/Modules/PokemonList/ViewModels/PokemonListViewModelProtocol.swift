//
//  PokemonListViewModelType.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 23/09/23.
//

import UIKit

protocol PokemonListViewModelProtocol: AnyObject {
    var delegate: PokemonListViewModelDelegate? { get set }
    var filterPokemon: [Pokemon] { get }
    
    func loadPokemonList()
    func filterPokemons(with searchText: String)
    func loadPokemonImage(from url: String, completion: @escaping (UIImage?) -> Void)
}

//
//  PokemonDetailViewModelProtocol.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 25/09/23.
//

import UIKit

protocol PokemonDetailViewModelProtocol: AnyObject {
    func loadPokemonImageDetail(from url: URL, completion: @escaping (UIImage?) -> Void)
    func handleImageLoadingError()
}

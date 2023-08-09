//
//  PokemonImageServiceProtocol.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import Foundation
import UIKit

protocol PokemonImageServiceProtocol {
    func fetchImagePokemon(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void)
    func getImagePokemon(from url: URL, completion: @escaping (UIImage?) -> Void)
}

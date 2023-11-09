//
//  DownloadImagePokemon.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 12/06/23.
//

import UIKit

class PokemonImageService: PokemonImageServiceProtocol {
    
    func fetchImagePokemon(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else {
                completion(.success(nil))
                return
            }
            
            let image = UIImage(data: responseData)
            completion(.success(image))
        }
        task.resume()
    }
    
    func getImagePokemon(from url: URL, completion: @escaping (UIImage?) -> Void) {
        fetchImagePokemon(from: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to download image: \(error)")
                completion(nil)
            }
        }
    }
}

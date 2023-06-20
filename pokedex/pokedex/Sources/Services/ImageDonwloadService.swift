//
//  DownloadImagePokemon.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 12/06/23.
//

import UIKit

class ImageDownloadService {
    
    func imageDownload(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
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
}

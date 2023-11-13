//
//  PokemonListSearchBar.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 13/11/23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func didChangeSearchBar(_ searchText: String)
}

class PokemonListSearchBar: NSObject, UISearchBarDelegate {
    
    weak var delegate: SearchBarDelegate?
    
    func setupSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchBar(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

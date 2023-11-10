//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 25/09/23.

import UIKit

class PokemonDetailViewModel {
    
    private let service: ServiceProtocol
    
    init( service: ServiceProtocol = Service()) {
        self.service = service
    }
}

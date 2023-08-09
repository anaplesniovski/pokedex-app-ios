//
//  PokemonListConstants.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 08/06/23.
//

import UIKit

struct PokemonListConstants {
    
    struct PokemonListViewController {
        
        struct PokeballImageView {
            static let top: CGFloat = 2
            static let leading: CGFloat = 2
            static let trailing: CGFloat = 2
        }
        
        struct TitleLabel {
            static let top: CGFloat = 120
            static let leading: CGFloat = 40
            static let trailing: CGFloat = -40
        }
        
        struct DescriptionSearchLabel {
            static let top: CGFloat = 12
            static let leading: CGFloat = 40
            static let trailing: CGFloat = -40
        }
        
        struct SearchTextField {
            static let top: CGFloat = 18
            static let leading: CGFloat = 40
            static let trailing: CGFloat = -40
            static let height: CGFloat = 40
        }
        
        struct PokemonTableView {
            static let top: CGFloat = 50
        }
    }
}

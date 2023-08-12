//
//  PokemonListCellConstants.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 09/06/23.
//

import UIKit

struct PokemonListCellConstants {
    
    struct PokemonListCell {
        
        struct StackView {
            static let height: CGFloat = 130
        }
        
        struct View {
            static let height: CGFloat = 130
        }
        
        struct IdLabel {
            static let top: CGFloat = 20
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -194
        }
        
        struct NameLabel {
            static let top: CGFloat = 18
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -194
        }
        
        struct TypeLbale {
            static let top: CGFloat = 12
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -180
        }
        
        struct PokemonImageView {
            static let trailing: CGFloat = -25
            static let height: CGFloat = 130
            static let width: CGFloat = 130
        }
    }
}

//
//  PokemonDetailsData.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

struct PokemonDetails: Decodable, Equatable {

    let name: String
    let height: Int
    let weight: Int
    let image: Image
    let types: [TypePokemon]
    let id: Int
    let species: Species

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case weight
        case image = "sprites"
        case types
        case id
        case species
    }

    static func == (lhs: PokemonDetails, rhs: PokemonDetails) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Image: Decodable {
    let imagePositions: ImagePositions

    enum CodingKeys: String, CodingKey {
        case imagePositions = "other"
    }
}

struct ImagePositions: Decodable {
    let frontDefault: FrontDefault

    enum CodingKeys: String, CodingKey {
        case frontDefault = "home"
    }
}

struct FrontDefault: Decodable {
    let imageURLFront: String

    enum CodingKeys: String, CodingKey {
        case imageURLFront = "front_default"
    }
}

struct TypePokemon: Decodable {
    let type: TypeName

    enum CodingKeys: CodingKey {
        case type
    }
}

struct TypeName: Decodable {
    let name: String

    enum CodingKeys: CodingKey {
        case name
    }
}

struct Species: Decodable {
    var url: String
}

struct PokemonColor: Decodable {
    let color: Color
}

struct Color: Decodable {
    let name: String
}

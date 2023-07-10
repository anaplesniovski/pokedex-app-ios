//
//  PokemonDetailsData.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation

struct PokemonDetailsData: Decodable {
    let name: String
    let height: Int
    let weight: Int
    let image: ImageData
    let types: [TypeData]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case weight
        case image = "sprites"
        case types
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.image = try container.decode(ImageData.self, forKey: .image)
        self.types = try container.decode([TypeData].self, forKey: .types)
        self.id = try container.decode(Int.self, forKey: .id)
    }
}

struct ImageData: Decodable {
    let imagePositions: ImagePositionsData
    
    enum CodingKeys: String, CodingKey {
        case imagePositions = "other"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imagePositions = try container.decode(ImagePositionsData.self, forKey: .imagePositions)
    }
}

struct ImagePositionsData: Decodable {
    let frontDefault: FrontDefaultData
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "home"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decode(FrontDefaultData.self, forKey: .frontDefault)
    }
}

struct FrontDefaultData: Decodable {
    let imageURLFront: String
    
    enum CodingKeys: String, CodingKey {
        case imageURLFront = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURLFront = try container.decode(String.self, forKey: .imageURLFront)
    }
}

struct TypeData: Decodable {
    let type: TypeNameData
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(TypeNameData.self, forKey: .type)
    }
}

struct TypeNameData: Decodable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

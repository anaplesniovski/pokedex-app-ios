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
    let images: ImagesData
    let types: [TypeData]
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case weight
        case images = "sprites"
        case types
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.images = try container.decode(ImagesData.self, forKey: .images)
        self.types = try container.decode([TypeData].self, forKey: .types)
    }
}

struct ImagesData: Decodable {
    let imageUrl: urlImageData
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "other"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(urlImageData.self, forKey: .imageUrl)
    }
}

struct urlImageData: Decodable {
    let urlImageData: FrontDefault
    
    enum CodingKeys: String, CodingKey {
        case urlImageData = "dream_world"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.urlImageData = try container.decode(FrontDefault.self, forKey: .urlImageData)
    }
}

struct FrontDefault: Decodable {
    let frontdefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontdefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontdefault = try container.decode(String.self, forKey: .frontdefault)
    }
}

struct TypeData: Decodable {
    let type: TypeName
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(TypeName.self, forKey: .type)
    }
}

struct TypeName: Decodable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

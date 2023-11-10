//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/08/23.
//

import UIKit

protocol PokemonDetailsDelegate: AnyObject {
    func didFetchPokemonList(pokemonDetails: [PokemonDetails])
    func showError(error: Error)
}

class PokemonListViewModel {

    private var allPokemons: [PokemonDetails] = []
    var filteredPokemon: [PokemonDetails] = []

    var pokemon: [PokemonDetails] {
        return filteredPokemon.isEmpty ? allPokemons : filteredPokemon
    }

    weak var delegate: PokemonDetailsDelegate?
    private let service: ServiceProtocol

    init(delegate: PokemonDetailsDelegate?, service: ServiceProtocol = Service()) {
        self.delegate = delegate
        self.service = service
    }

    func fetchPokemons() {
        let group = DispatchGroup()

        var pokemonDetails: [PokemonDetails] = []

        service.getPokemons(route: Pokedex.pokemon, type: Pokemons.self) { [weak self] result in
            switch result {
            case let .success(model):
                group.enter()
                self?.fetchPokemonDetails(pokemons: model.results) { (pokemonsDetails) in
                    group.leave()
                    pokemonDetails = pokemonsDetails
                }
            case let .failure(error):
                self?.delegate?.showError(error: error)
            }
        }

        group.notify(queue: .main) {
            self.delegate?.didFetchPokemonList(pokemonDetails: pokemonDetails)
        }
    }

    func fetchPokemonDetails(pokemons: [Pokemon], completion: @escaping ([PokemonDetails]) -> Void) {
        var pokemonsDetails: [PokemonDetails] = []
        let group = DispatchGroup()

        for pokemon in pokemons {
            let name = pokemon.name
            group.enter()
            service.getPokemons(route: Pokedex.pokemonDetails(name: name), type: PokemonDetails.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case let .success(details):
                    pokemonsDetails.append(details)
                    self.allPokemons = pokemonsDetails
                    self.filteredPokemon = pokemonsDetails
                    self.delegate?.didFetchPokemonList(pokemonDetails: pokemonsDetails)

                case let .failure(error):
                    self.delegate?.showError(error: error)
                }
            }
        }

        group.notify(queue: .main) {
            completion(pokemonsDetails)
        }
    }


    func fetchPokemonColor() {
        service.getPokemons(route: Pokedex.pokemonColor, type: PokemonColor.self) { result in
            switch result {
            case let .success(colorInfo):
                print("teste\(colorInfo)")
            case let .failure(error):
                self.delegate?.showError(error: error)
            }
        }
    }

    func filterPokemon(with searchText: String) {
        if searchText.isEmpty {
            filteredPokemon = allPokemons
        } else {
            filteredPokemon = allPokemons.filter { pokemon in
                return pokemon.name.lowercased().contains(searchText.lowercased())
            }
        }

        delegate?.didFetchPokemonList(pokemonDetails: pokemon)
    }
}

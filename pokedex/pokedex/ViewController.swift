//
//  ViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemonList: [PokemonDetailsData] = []
    var pokemon: [Pokemon] = []
    var cellIdentifier = "PokemonCell"
    var pokemon2: [PokemonDetailsData] = []
    
    private lazy var pokeballImage: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 414, 414))
        imageView.image = UIImage(named: "pokeball")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titlePokedex: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokédex"
        label.textColor = .black
        label.font = .systemFont(ofSize: 44)
        return label
    }()
    
    private lazy var descriptionSearchPokemon: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Busque o Pokémon pelo nome ou usando o número Pokédex Nacional"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var searchPokemon: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "  Qual Pokémon você está procurando?"
        textField.backgroundColor = .gray
        return textField
    }()
    
    private lazy var listPokemon: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        setContransts()
        setContranstsTableView()
        listPokemon.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
//        PokemonRequest().getPokemonDetails { pokemonList in
//            self.pokemonList = pokemonList
//            DispatchQueue.main.async {
//                self.listPokemon.reloadData()
//                print(pokemonList)
//            }
//        }
        
        PokemonRequest().getPokemonDetails { pokemon in
            self.pokemon = pokemon
            DispatchQueue.main.async {
                self.listPokemon.reloadData()
                print(pokemon)
            }
        }
    }
    
    private func addComponents() {
        view.addSubview(pokeballImage)
        view.addSubview(titlePokedex)
        view.addSubview(descriptionSearchPokemon)
        view.addSubview(searchPokemon)
        view.addSubview(listPokemon)
    }
    
    private func setContransts() {
        pokeballImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pokeballImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        pokeballImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2).isActive = true
        pokeballImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 2).isActive = true

        titlePokedex.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        titlePokedex.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        titlePokedex.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true

        descriptionSearchPokemon.topAnchor.constraint(equalTo: titlePokedex.bottomAnchor, constant: 12).isActive = true
        descriptionSearchPokemon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        descriptionSearchPokemon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true

        searchPokemon.topAnchor.constraint(equalTo: descriptionSearchPokemon.bottomAnchor, constant: 18).isActive = true
        searchPokemon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        searchPokemon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        searchPokemon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setContranstsTableView() {
        NSLayoutConstraint.activate([
            listPokemon.topAnchor.constraint(equalTo: searchPokemon.bottomAnchor, constant: 50),
            listPokemon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listPokemon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            listPokemon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text? = "picachu"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

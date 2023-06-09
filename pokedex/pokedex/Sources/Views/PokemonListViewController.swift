//
//  ViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let constants = PokemonListConstants.PokemonListViewController.self
    var pokemons: [Pokemon] = []

    private lazy var pokeballImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 414, 414))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokédex"
        label.textColor = .black
        label.font = .systemFont(ofSize: 44)
        return label
    }()
    
    private lazy var descriptionSearchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Busque o Pokémon pelo nome ou usando o número Pokédex Nacional"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Qual Pokémon você está procurando?"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return textField
    }()
    
    private lazy var pokemonTableView: UITableView = {
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
        pokemonTableView.register(PokemonListCell.self, forCellReuseIdentifier: "pokemonCell")
        
        PokemonService().getListPokemonDetails { [weak self] pokemonDetails in
            self?.pokemons = pokemonDetails
            DispatchQueue.main.async {
                self?.pokemonTableView.reloadData()
            }
        }
    }
    
    private func addComponents() {
        view.addSubview(pokeballImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionSearchLabel)
        view.addSubview(searchTextField)
        view.addSubview(pokemonTableView)
    }
    
    private func setContransts() {
        NSLayoutConstraint.activate([
            pokeballImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.PokeballImageView.top),
            pokeballImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.PokeballImageView.leading),
            pokeballImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.PokeballImageView.trailing),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.TitleLabel.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.TitleLabel.leading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.TitleLabel.trailing),

            descriptionSearchLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: constants.DescriptionSearchLabel.top),
            descriptionSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.DescriptionSearchLabel.leading),
            descriptionSearchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.DescriptionSearchLabel.trailing),

            searchTextField.topAnchor.constraint(equalTo: descriptionSearchLabel.bottomAnchor, constant: constants.SearchTextField.top),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.SearchTextField.leading),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.SearchTextField.trailing),
            searchTextField.heightAnchor.constraint(equalToConstant: constants.SearchTextField.height),
            
            pokemonTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: constants.PokemonTableView.top),
            pokemonTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonListCell
        cell.configure = pokemons[indexPath.row]
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

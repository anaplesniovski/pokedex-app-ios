//
//  ViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemons: [Pokemon] = []

    private lazy var pokeballImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 414, 414))
        imageView.image = UIImage(named: "pokeball")
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        setContranstsTableView()
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
        pokeballImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pokeballImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        pokeballImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2).isActive = true
        pokeballImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 2).isActive = true

        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true

        descriptionSearchLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        descriptionSearchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        descriptionSearchLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true

        searchTextField.topAnchor.constraint(equalTo: descriptionSearchLabel.bottomAnchor, constant: 18).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setContranstsTableView() {
        NSLayoutConstraint.activate([
            pokemonTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 50),
            pokemonTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonListCell
        cell.pokemonDetails = pokemons[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

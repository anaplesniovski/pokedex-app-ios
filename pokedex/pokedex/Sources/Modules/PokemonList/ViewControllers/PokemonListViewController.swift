//
//  ViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let viewModel: PokemonListViewModelProtocol
    private let constants = PokemonListConstants.PokemonListViewController.self
    private let pokemonImageService = PokemonImageService()
    
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
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Qual Pokémon você está procurando?"
        textField.textAlignment = .center
        textField.textColor = .black
        textField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        textField.delegate = self
        return textField
    }()
    
    private lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        addComponents()
        addContransts()
        pokemonTableView.register(PokemonListCell.self, forCellReuseIdentifier: "pokemonCell")
        viewModel.loadPokemonList()
    }
    
    private func addComponents() {
        view.addSubview(pokeballImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionSearchLabel)
        view.addSubview(searchTextField)
        view.addSubview(pokemonTableView)
    }
    
    private func addContransts() {
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
        return viewModel.filterPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonListCell
        cell.configure = viewModel.filterPokemon[indexPath.row]
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = viewModel.filterPokemon[indexPath.row]
        let pokemonDetailViewModel = PokemonDetailViewModel(pokemonImageService: pokemonImageService)
        let detailPokemon = PokemonDetailViewController(pokemonDetailViewModel: pokemonDetailViewModel)
        detailPokemon.pokemon = selectedPokemon
        detailPokemon.configure(with: selectedPokemon)
        navigationController?.pushViewController(detailPokemon, animated: true)
    }
}

extension PokemonListViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchText = textField.text {
            viewModel.filterPokemons(with: searchText)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func updatePokemonList() {
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
}

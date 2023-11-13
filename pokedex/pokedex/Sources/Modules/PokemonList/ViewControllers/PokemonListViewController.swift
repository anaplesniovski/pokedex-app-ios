//
//  ViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let constants = PokemonListConstants.PokemonListViewController.self
    lazy var viewModel = PokemonListViewModel(delegate: self)
    var pokemonDetails: [PokemonDetails]?
    
    private lazy var imageView: UIImageView = {
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
    
    private lazy var textLabel: UILabel = {
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Qual Pokémon você está procurando?"
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = true
        searchBar.layer.cornerRadius = 10
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init() {
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
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: "pokemonCell")
        viewModel.fetchPokemons()
    }
    
    private func addComponents() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func addContransts() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.ImageView.top),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.ImageView.leading),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.ImageView.trailing),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.TitleLabel.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.TitleLabel.leading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.TitleLabel.trailing),

            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: constants.TextLabel.top),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.TextLabel.leading),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.TextLabel.trailing),

            searchBar.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: constants.SearchBar.top),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.SearchBar.leading),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.SearchBar.trailing),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: constants.TableView.top),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func updateView(pokemon: [PokemonDetails]) {
        self.pokemonDetails = pokemon
        self.tableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonListCell
        
        if let pokemon = pokemonDetails?[indexPath.row] {
            cell.configure(with: pokemon, image: nil)
            
            viewModel.fetchImage(for: pokemon) { [weak cell] image in
                DispatchQueue.main.async {
                    cell?.configureImage(image)
                }
            }
        }
        
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedPokemon = pokemonDetails?[indexPath.row] {
            let detailViewController = PokemonDetailsViewController()
            
            viewModel.fetchImage(for: selectedPokemon) { [weak detailViewController] image in
                DispatchQueue.main.async {
                    detailViewController?.configure(with: selectedPokemon, image: image)
                }
            }
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension PokemonListViewController: PokemonDetailsDelegate {
    func didFetchPokemonList(pokemonDetails: [PokemonDetails]) {
        DispatchQueue.main.async {
            self.updateView(pokemon: pokemonDetails)
            self.tableView.reloadData()
        }
    }
    
    func showError(error: Error) {
        print("\(error)")
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPokemon(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

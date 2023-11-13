//
//  PokemonDetailsViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 16/08/23.

import UIKit

class PokemonDetailsViewController: UIViewController {

    private let constants = PokemonDetailsConstants.PokemonDetailsViewController.self
    var pokemonDetails: PokemonDetails?
    var viewModel: PokemonDetailsViewModel?
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = pokemonDetails {
            viewModel = PokemonDetailsViewModel(pokemonDetails: pokemon)
        }
        
        view.backgroundColor = .white
        addComponents()
        addConstraints()
    }
    
    private func addComponents() {
        view.addSubview(pokemonImageView)
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([            
            pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.PokemonImageView.top),
            pokemonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.PokemonImageView.leading),
            pokemonImageView.heightAnchor.constraint(equalToConstant: constants.PokemonImageView.height),
            pokemonImageView.widthAnchor.constraint(equalToConstant: constants.PokemonImageView.width),
            
            idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.IdLabel.top),
            idLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: constants.IdLabel.leading),

            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: constants.NameLabel.top),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: constants.NameLabel.leading),

            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constants.TypeLabel.top),
            typeLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: constants.TypeLabel.leading)
        ])
    }
    
    func configure(with pokemon: PokemonDetails, image: UIImage?) {
            nameLabel.text = pokemon.name.capitalized
            typeLabel.text = pokemon.types.map { $0.type.name.capitalized }.joined(separator: " / ")
            idLabel.text = String(pokemon.id)
            pokemonImageView.image = image
        }

    func configureImage(_ image: UIImage?) {
           pokemonImageView.image = image
       }
}


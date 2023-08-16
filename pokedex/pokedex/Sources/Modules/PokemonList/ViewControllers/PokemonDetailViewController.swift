//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 16/08/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
    }
    
    private func addComponents() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(pokemonImageView)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pokemonImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100),
            pokemonImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 35),
            
            idLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 110),
            idLabel.leadingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: 10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: 10)
        ])
    }
}

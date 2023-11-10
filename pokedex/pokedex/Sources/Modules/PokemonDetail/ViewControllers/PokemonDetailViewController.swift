//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 16/08/23.

import UIKit

class PokemonDetailViewController: UIViewController {

    private let constants = PokemonDetailConstants.PokemonDetailViewController.self
    var pokemon: [PokemonDetails]?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        addConstraints()
    }
    
    private func addComponents() {
        view.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(pokemonImageView)
        mainView.addSubview(idLabel)
        mainView.addSubview(nameLabel)
        mainView.addSubview(typeLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: constants.StackView.top),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: constants.StackView.leading),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: constants.StackView.trailing),
            stackView.heightAnchor.constraint(equalToConstant: constants.StackView.height),
            
            pokemonImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            idLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: constants.IdLabel.top),
            idLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: constants.IdLabel.leading),
            idLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: constants.IdLabel.trailing),
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: constants.NameLabel.top),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: constants.NameLabel.leading),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: constants.NameLabel.trailing),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constants.TypeLabel.top),
            typeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: constants.TypeLabel.leading),
            typeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: constants.TypeLabel.trailing)
        ])
    }
    
    func configureUI(with pokemon: PokemonDetails) {
        
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        typeLabel.text = pokemon.types.map { $0.type.name.capitalized }.joined(separator: " / ")

        guard let imageURL = URL(string: pokemon.image.imagePositions.frontDefault.imageURLFront) else { return }
    
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = UIImage(data: data)
                }
            } else if let error = error {
                print("Erro ao carregar a imagem: \(error)")
            }
        }.resume()
    }
}


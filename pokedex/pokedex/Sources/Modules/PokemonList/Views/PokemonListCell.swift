//
//  PokemonListCell.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import UIKit

class PokemonListCell: UITableViewCell {
    
    private let constants = PokemonListCellConstants.PokemonListCell.self
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addComponents()
        addContransts()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        addContransts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        contentView.addSubview(customView)
        customView.addSubview(idLabel)
        customView.addSubview(nameLabel)
        customView.addSubview(typeLabel)
        customView.addSubview(pokemonImageView)
    }
    
    private func addContransts() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constants.CustomView.top),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constants.CustomView.leading),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: constants.CustomView.trailing),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: constants.CustomView.bottom),
            
            idLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: constants.IdLabel.top),
            idLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: constants.IdLabel.leading),
            idLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: constants.IdLabel.trailing),
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.topAnchor, constant: constants.NameLabel.top),
            nameLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: constants.NameLabel.leading),
            nameLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: constants.NameLabel.trailing),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constants.TypeLbale.top),
            typeLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: constants.TypeLbale.leading),
            typeLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: constants.TypeLbale.trailing),
            
            pokemonImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: constants.PokemonImageView.top),
            pokemonImageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: constants.PokemonImageView.trailing),
            pokemonImageView.widthAnchor.constraint(equalToConstant: constants.PokemonImageView.width),
            pokemonImageView.heightAnchor.constraint(equalToConstant: constants.PokemonImageView.height)
            
        ])
    }
    
    var configure: PokemonDetails? {
        didSet {
            guard let pokemon = configure else { return }
            nameLabel.text = pokemon.name.capitalized
            typeLabel.text = pokemon.types.map { $0.type.name.capitalized }.joined(separator: " / ")
            idLabel.text = String(pokemon.id)
            
            if let color = pokemon.species.colorUrl as String? {
                let uiColor = UIColor(named: color) ?? .white
                customView.backgroundColor = uiColor
            } else {
                customView.backgroundColor = .white
            }
            
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
}



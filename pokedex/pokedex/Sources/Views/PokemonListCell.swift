//
//  PokemonListCell.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation
import UIKit

class PokemonListCell: UITableViewCell {
    
    private let constants = PokemonListCellConstants.PokemonListCell.self
    let imageDownloadServide = ImageDownloadService()
    var imageDownloadTask: URLSessionDataTask?

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = .systemFont(ofSize: 26)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        setContransts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addComponents() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(view)
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(pokemonImageView)
    }
    
    private func setContransts() {
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        stackView.heightAnchor.constraint(equalToConstant: constants.StackView.height),
        
        view.topAnchor.constraint(equalTo: stackView.topAnchor),
        view.leadingAnchor.constraint(equalTo: leadingAnchor),
        view.trailingAnchor.constraint(equalTo: trailingAnchor),
        view.heightAnchor.constraint(equalToConstant: constants.View.height),
        
        idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.IdLabel.top),
        idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.IdLabel.leading),
        idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.IdLabel.trailing),
        
        nameLabel.topAnchor.constraint(equalTo: idLabel.topAnchor, constant: constants.NameLabel.top),
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.NameLabel.leading),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.NameLabel.trailing),
        
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constants.TypeLbale.top),
        typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.TypeLbale.leading),
        typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.TypeLbale.trailing),
        
        pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor),
        pokemonImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        pokemonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.PokemonImageView.leading),
        pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.PokemonImageView.trailing),
        pokemonImageView.widthAnchor.constraint(equalToConstant: constants.PokemonImageView.width)

        ])
    }
    
    var configure: Pokemon? {
        didSet {
            guard let pokemon = configure else { return }
            nameLabel.text = pokemon.name.capitalized
            typeLabel.text = pokemon.types.isEmpty == true ? "" : pokemon.types.joined(separator: " / ").capitalized
            idLabel.text = String(pokemon.id)
            
            if let imageURL = URL(string: pokemon.image) {
                setImage(from: imageURL)
            }
        }
    }
    
    private func setImage(from url: URL) {
        imageDownloadServide.imageDownload(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.pokemonImageView.image = image
                case .failure(let error):
                    print("Failed to download image from URL: \(url). Error: \(error)")
                }
            }
        }
    }
}

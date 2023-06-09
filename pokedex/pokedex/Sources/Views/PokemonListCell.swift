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
    
    var details: Pokemon? {
        didSet {
            guard let pokemon = details else { return }
            nameLabel.text = pokemon.name
            typeLabel.text = pokemon.types.isEmpty == true ? "" : pokemon.types.joined(separator: " / ")
            idLabel.text = String(pokemon.id)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        setContransts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 26)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private func addComponents() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(view)
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
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
        typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constants.TypeLbale.trailing)
        ])
    }
}

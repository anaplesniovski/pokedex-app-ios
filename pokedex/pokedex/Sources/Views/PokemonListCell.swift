//
//  PokemonListCell.swift
//  pokedex
//
//  Created by Ana Paula Lesniovski dos Santos on 01/06/23.
//

import Foundation
import UIKit

class PokemonListCell: UITableViewCell {
    
    var details: Pokemon? {
        didSet {
            guard let pokemon = details else { return }
            nameLabel.text = pokemon.name
            typeLabel.text = pokemon.types.isEmpty == true ? "" : pokemon.types.joined(separator: " ")
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
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
    }
    
    private func setContransts() {
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        stackView.heightAnchor.constraint(equalToConstant: 130),
        
        view.topAnchor.constraint(equalTo: stackView.topAnchor),
        view.leadingAnchor.constraint(equalTo: leadingAnchor),
        view.trailingAnchor.constraint(equalTo: trailingAnchor),
        view.heightAnchor.constraint(equalToConstant: 130),
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -194),
        
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
        typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180)
        ])
    }
}

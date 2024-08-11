//
//  ProfileCell.swift
//  KingBurguer
//
//  Created by Natã Romão on 16/06/23.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    static let identifier = "ProfileCell"
    
    var data: (String, String)! {
        willSet {
            leftLabel.text = newValue.0
            rightLabel.text = newValue.1
        }
    }
    
    private let leftLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Ola mundo"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let rightLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Hello world"
        lb.textColor = .systemGray
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 10),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
}

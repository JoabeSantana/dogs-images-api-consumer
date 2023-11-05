//
//  studentInfoTableViewCell.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 04/11/23.
//

import UIKit

class StudentInfoTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String = "StudentInfoTableViewCell"
    
    private let identifierLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ItemList) {
        identifierLabel.text = item.identifier
        descriptionLabel.text = item.description
    }
}

// MARK: IU Methods

extension StudentInfoTableViewCell {
    func configureView(){
        self.contentView.addSubview(identifierLabel)
        self.contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            identifierLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            identifierLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            identifierLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

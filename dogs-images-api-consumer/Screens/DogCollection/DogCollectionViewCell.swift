//
//  DogCollectionViewCell.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

final class DogCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "DogCollectionViewCell"
    
    private let dogImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 0
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureImageView()
        configureLabels()
        
        self.contentView.backgroundColor = .systemGray
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        dogImageView.image = nil
        nameLabel.text = nil
    }

    func configure(dog: Dog) {
        
        nameLabel.text = dog.breed?.name
        
        ImageManager.shared.loadImage(from: URL(string: dog.url)) { 
            [weak self] image in self?.dogImageView.image = image
        }
    }
}

// MARK: - UI methods

private extension DogCollectionViewCell {
    func configureImageView() {
        
        contentView.addSubview(dogImageView)
        
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dogImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            dogImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            dogImageView.heightAnchor.constraint(equalToConstant: 100),
            dogImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    func configureLabels() {
        
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalTo: dogImageView.widthAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: dogImageView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}

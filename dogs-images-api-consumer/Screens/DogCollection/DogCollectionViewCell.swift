//
//  DogCollectionViewCell.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

final class DogCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String = "DogCollectionViewCell"


    private let profileImageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
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
        profileImageView.image = nil
        nameLabel.text = nil
    }

    func configure(character: Dog) {
        nameLabel.text = character.breed.first?.name
        ImageManager.shared.loadImage(from: URL(string: character.url)) { [weak self] image in
            self?.profileImageView.image = image
        }
    }
}

// MARK: - UI methods

private extension DogCollectionViewCell {
    func configureImageView() {
        contentView.addSubview(profileImageView)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 0
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    func configureLabels() {
        contentView.addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalTo: profileImageView.widthAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}

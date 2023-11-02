//
//  DogDetailViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var dogImageView = UIImageView()
    
    var nameLabel = UILabel()
    
    private var bredForLabel = UILabel()
    
    private var breedGroupLabel = UILabel()
    
    private var labelsStackView = UIStackView()
    
    private var dog: Dog
    
    init(character: Dog) {
        self.dog = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
        configureLabels()
        configureViewLayout()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = dog.breed.first?.name
    }
    
    private func configureImage () {
        guard let imageURL = URL(string: dog.url) else { return }
        dogImageView.load(url: imageURL)
        view.addSubview(dogImageView)
    }
    
    private func configureLabels() {
        nameLabel.text = "Name: \(dog.breed.first?.name ?? "n/a")"
        nameLabel.font = .preferredFont(forTextStyle: .title1)
        nameLabel.textColor = .white
        
        bredForLabel.text = "Bred for: \(dog.breed.first?.bredFor ?? "n/a")"
        bredForLabel.font = .preferredFont(forTextStyle: .title2)
        bredForLabel.textColor = .white
        
//        bredForLabel.text = "Temperament: \(dog.breed.first?.temperament ?? "n/a")"
//        bredForLabel.font = .preferredFont(forTextStyle: .title2)
//        bredForLabel.textColor = .white
        
        breedGroupLabel.text = "Species: \(dog.breed.first?.name ?? "n/a")"
        breedGroupLabel.font = .preferredFont(forTextStyle: .title2)
        breedGroupLabel.textColor = .white
        
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing   = 4.0
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(bredForLabel)
        labelsStackView.addArrangedSubview(breedGroupLabel)
        
        view.addSubview(labelsStackView)
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureViewLayout() {
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        bredForLabel.translatesAutoresizingMaskIntoConstraints = false
        breedGroupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dogImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 8.0),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            labelsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}

//
//  DogDetailViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var dogImageView: UIImageView = {
        let uiImage = UIImageView();
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        return uiImage
    }()
    
    var heightLabel = UILabel()
    var heightValueLabel = UILabel()
    
    private var weightLabel = UILabel()
    var weightValueLabel = UILabel()
    
    private var lifeSpanLabel = UILabel()
    var lifeSpanValueLabel = UILabel()
    
    private var bredGroupLabel = UILabel()
    var bredGroupValueLabel = UILabel()
    
    private var sumaryLabel = UILabel()
    private var sumaryValueLabel = UILabel()
    
    private var labelsHorizontalStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .equalSpacing
        labelsStackView.alignment = .top
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    private var valuesHorizontalStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .equalSpacing
        labelsStackView.alignment = .top
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    private var bredGroupVerticalStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        //labelsStackView.spacing = 8
        labelsStackView.alignment = .top
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    private var sumaryVerticalStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        labelsStackView.alignment = .top
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
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
        configureValues()
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
        dogImageView.heightAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        dogImageView.contentMode = .scaleToFill
        view.addSubview(dogImageView)
    }
    
    private func configureLabels() {
        heightLabel.text = "Height"
        heightLabel.font = .preferredFont(forTextStyle: .title3)
        heightLabel.textColor = .white
        
        weightLabel.text = "Weight"
        weightLabel.font = .preferredFont(forTextStyle: .title3)
        weightLabel.textColor = .white
        
        lifeSpanLabel.text = "Life Span"
        lifeSpanLabel.font = .preferredFont(forTextStyle: .title3)
        lifeSpanLabel.textColor = .white
        
        bredGroupLabel.text = "Bred Group"
        bredGroupLabel.font = .preferredFont(forTextStyle: .title3)
        bredGroupLabel.textColor = .white
        
        sumaryLabel.text = "Sumary"
        sumaryLabel.font = .preferredFont(forTextStyle: .title3)
        sumaryLabel.textColor = .white
        
        labelsHorizontalStackView.addArrangedSubview(heightLabel)
        labelsHorizontalStackView.addArrangedSubview(weightLabel)
        labelsHorizontalStackView.addArrangedSubview(lifeSpanLabel)
        
        bredGroupVerticalStackView.addArrangedSubview(bredGroupLabel)
        
        sumaryVerticalStackView.addArrangedSubview(sumaryLabel)
        
        view.addSubview(labelsHorizontalStackView)
        view.addSubview(bredGroupVerticalStackView)
        view.addSubview(sumaryVerticalStackView)
    }
    
    private func configureValues() {
        heightValueLabel.text = "\(dog.breed.first?.height.imperial ?? "--")"
        heightValueLabel.textColor = .white
        
        weightValueLabel.text = "\(dog.breed.first?.weight.imperial ?? "--")"
        weightValueLabel.textColor = .white
        
        lifeSpanValueLabel.text = "\(dog.breed.first?.lifeSpan ?? "--")"
        lifeSpanValueLabel.textColor = .white
        
        bredGroupValueLabel.text = "\(dog.breed.first?.breedGroup ?? "--")"
        
        sumaryValueLabel.text = """
A dog of a temperament \(dog.breed.first?.temperament ?? "unknown").
A breed for \(dog.breed.first?.bredFor ?? "unknown").
"""
        sumaryValueLabel.numberOfLines = 5
        
        valuesHorizontalStackView.addArrangedSubview(heightValueLabel)
        valuesHorizontalStackView.addArrangedSubview(weightValueLabel)
        valuesHorizontalStackView.addArrangedSubview(lifeSpanValueLabel)
        
        bredGroupVerticalStackView.addArrangedSubview(bredGroupValueLabel)
        
        sumaryVerticalStackView.addArrangedSubview(sumaryValueLabel)
        
        view.addSubview(valuesHorizontalStackView)
    }
    
    private func configureViewLayout() {
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dogImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            labelsHorizontalStackView.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 8.0),
            labelsHorizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            labelsHorizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            //labelsHorizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            valuesHorizontalStackView.topAnchor.constraint(equalTo: labelsHorizontalStackView.bottomAnchor, constant: 0),
            valuesHorizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            valuesHorizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            
            bredGroupVerticalStackView.topAnchor.constraint(equalTo: valuesHorizontalStackView.bottomAnchor, constant: 15),
            bredGroupVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            bredGroupVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            
            sumaryVerticalStackView.topAnchor.constraint(equalTo: bredGroupVerticalStackView.bottomAnchor, constant: 15),
            sumaryVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            sumaryVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            
        ])
    }
}

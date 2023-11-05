//
//  DogDetailViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var scrollContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
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
    
    init(dog: Dog) {
        self.dog = dog
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
}

// MARK: - UI Methods

extension DogDetailViewController {
    private func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = dog.breed?.name
    }
    
    private func configureImage () {
        guard let imageURL = URL(string: dog.url) else { return }
        dogImageView.load(url: imageURL)
        dogImageView.heightAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        dogImageView.contentMode = .scaleToFill
    }
    
    private func configureLabels() {
        heightLabel.text = "Height"
        heightLabel.font = .preferredFont(forTextStyle: .headline)
        
        weightLabel.text = "Weight"
        weightLabel.font = .preferredFont(forTextStyle: .headline)
        
        lifeSpanLabel.text = "Life Span"
        lifeSpanLabel.font = .preferredFont(forTextStyle: .headline)
        
        bredGroupLabel.text = "Bred Group"
        bredGroupLabel.font = .preferredFont(forTextStyle: .headline)
        
        sumaryLabel.text = "Sumary"
        sumaryLabel.font = .preferredFont(forTextStyle: .headline)
        
        labelsHorizontalStackView.addArrangedSubview(heightLabel)
        labelsHorizontalStackView.addArrangedSubview(weightLabel)
        labelsHorizontalStackView.addArrangedSubview(lifeSpanLabel)
        
        bredGroupVerticalStackView.addArrangedSubview(bredGroupLabel)
        
        sumaryVerticalStackView.addArrangedSubview(sumaryLabel)
    }
    
    private func configureValues() {
        heightValueLabel.text = "\(dog.breed?.height.imperial ?? "--")"
        
        weightValueLabel.text = "\(dog.breed?.weight.imperial ?? "--")"
        
        lifeSpanValueLabel.text = "\(dog.breed?.lifeSpan ?? "--")"
        
        bredGroupValueLabel.text = "\(dog.breed?.breedGroup ?? "--")"
        
        sumaryValueLabel.text = """
A dog of a temperament \(dog.breed?.temperament?.lowercased() ?? "unknown").
A dog breed for \(dog.breed?.bredFor?.lowercased() ?? "unknown").
"""
        sumaryValueLabel.numberOfLines = 5
        
        valuesHorizontalStackView.addArrangedSubview(heightValueLabel)
        valuesHorizontalStackView.addArrangedSubview(weightValueLabel)
        valuesHorizontalStackView.addArrangedSubview(lifeSpanValueLabel)
        
        bredGroupVerticalStackView.addArrangedSubview(bredGroupValueLabel)
        
        sumaryVerticalStackView.addArrangedSubview(sumaryValueLabel)
    }
    
    private func configureViewLayout() {
        
        let contentLayoutGuide = scrollView.contentLayoutGuide
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint (equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollContainer.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            scrollContainer.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            scrollContainer.heightAnchor.constraint(equalToConstant: 700)
        ])
        
        scrollContainer.addSubview(dogImageView)
        scrollContainer.addSubview(labelsHorizontalStackView)
        scrollContainer.addSubview(valuesHorizontalStackView)
        scrollContainer.addSubview(bredGroupVerticalStackView)
        scrollContainer.addSubview(sumaryVerticalStackView)
        
        NSLayoutConstraint.activate([
            scrollContainer.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor),
            
            dogImageView.topAnchor.constraint(equalTo: scrollContainer.topAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            dogImageView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            
            labelsHorizontalStackView.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 8.0),
            labelsHorizontalStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            labelsHorizontalStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            
            valuesHorizontalStackView.topAnchor.constraint(equalTo: labelsHorizontalStackView.bottomAnchor, constant: 0),
            valuesHorizontalStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            valuesHorizontalStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            
            bredGroupVerticalStackView.topAnchor.constraint(equalTo: valuesHorizontalStackView.bottomAnchor, constant: 15),
            bredGroupVerticalStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            bredGroupVerticalStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            
            sumaryVerticalStackView.topAnchor.constraint(equalTo: bredGroupVerticalStackView.bottomAnchor, constant: 15),
            sumaryVerticalStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            sumaryVerticalStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
        ])
    }
}

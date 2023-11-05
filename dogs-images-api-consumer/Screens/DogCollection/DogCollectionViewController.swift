//
//  DogCollectionViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

final class DogCollectionViewController: UIViewController {
    
    var dogList: [Dog] = []
    let service: DogService
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 2
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()

    init() {
        self.service = DogService()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()

        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.dogList = try await self.service.fetchDogList()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error)
                self.dogList = []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - UI Methods

extension DogCollectionViewController {
    func configureView() {
        
        super.navigationItem.title = "Dog Breeds"
        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            DogCollectionViewCell.self,
            forCellWithReuseIdentifier: DogCollectionViewCell.reuseIdentifier
        )
    }
}

// MARK: - UICollectionViewDataSource

extension DogCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogCollectionViewCell.reuseIdentifier, for: indexPath) as? DogCollectionViewCell else {
            return UICollectionViewCell()
        }

        let character = dogList[indexPath.row]
        cell.configure(dog: character)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DogCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentDog = dogList[indexPath.row]
        let dogDetailViewController = DogDetailViewController(dog: currentDog)
        
        navigationController?.pushViewController(dogDetailViewController, animated: true)
    }
}

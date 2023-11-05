//
//  InfoViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 04/11/23.
//

import Foundation
import UIKit

enum ListIdentifierEnum: String {
    case bio = "BIO"
    case studantId = "STUDANT ID"
    case email = "EMAIL"
    case phone = "PHONE"
}

class InfoViewController: UIViewController {
    
    let studant = Student(name: "Joabe Santana Correia", id: 2373171007, email: "joabesantana.c@gmail.com", phone: "(61) 99161-3281", bio: "A student who became very interesting and became an iOS development Lover ❤️")
    
    var itemList: [ItemList] = []
    
    var profileName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    var scrollView: UIScrollView = {
        let uiScrollView = UIScrollView()
        uiScrollView.translatesAutoresizingMaskIntoConstraints = false
        return uiScrollView
    }()
    
    var scrollContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    var profileImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.clipsToBounds = true
        uiImageView.layer.cornerRadius = 75
        uiImageView.layer.borderWidth = 2
        uiImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        return uiImageView
    }()
    
    private let tableView: UITableView = {
        let uiTableView = UITableView(frame: .zero, style: .insetGrouped)
        uiTableView.rowHeight = UITableView.automaticDimension
        uiTableView.estimatedRowHeight = 100
        uiTableView.translatesAutoresizingMaskIntoConstraints = false
        return uiTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureListItem()
        configureImage()
        configureLabels()
        configureTableView()
        configureViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func configureImage() {
        profileImageView.image = UIImage(named: "StudentImage")
    }

    private func configureListItem() {
        itemList.append(ItemList(identifier: ListIdentifierEnum.bio.rawValue, description: studant.bio))
        itemList.append(ItemList(identifier: ListIdentifierEnum.studantId.rawValue, description: studant.id.description))
        itemList.append(ItemList(identifier: ListIdentifierEnum.email.rawValue, description: studant.email))
        itemList.append(ItemList(identifier: ListIdentifierEnum.phone.rawValue, description: studant.phone))
    }
    
    private func configureLabels() {
        profileName.text = studant.name
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(StudentInfoTableViewCell.self, forCellReuseIdentifier: StudentInfoTableViewCell.reuseIdentifier)
    }
    
    private func configureViewLayout() {
        
        super.navigationItem.title = "Student Info"
        
        let contentLayoutGuide = scrollView.contentLayoutGuide
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(profileImageView)
        scrollContainer.addSubview(profileName)
        scrollContainer.addSubview(tableView)
        
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
        
        NSLayoutConstraint.activate([
            scrollContainer.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            //scrollContainer.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            //scrollContainer.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),

            scrollContainer.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 25),
            profileImageView.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            
            profileName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileName.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            profileName.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: profileName.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor),
        ])
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudentInfoTableViewCell.reuseIdentifier, for: indexPath) as? StudentInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: itemList[indexPath.row])
        
        return cell
    }
}

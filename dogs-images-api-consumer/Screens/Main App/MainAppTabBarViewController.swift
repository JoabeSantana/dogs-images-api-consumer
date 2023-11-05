//
//  MainAppTabBarViewController.swift
//  dogs-images-api-consumer
//
//  Created by Joabe Santana Correia on 02/11/23.
//

import UIKit

class MainAppTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .darkGray
        
        let dogCollectionNavigationController = UINavigationController(rootViewController: DogCollectionViewController())
        dogCollectionNavigationController.navigationBar.standardAppearance = appearance
        dogCollectionNavigationController.navigationBar.scrollEdgeAppearance = appearance
        
        let infoNavigationController = UINavigationController(rootViewController: InfoViewController())
        infoNavigationController.navigationBar.standardAppearance = appearance
        infoNavigationController.navigationBar.scrollEdgeAppearance = appearance

        dogCollectionNavigationController.tabBarItem = UITabBarItem(title: "Dogs", image: UIImage(systemName: "dog.circle"), tag: 1)
        
        infoNavigationController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), tag: 2)

        viewControllers = [
            dogCollectionNavigationController,
            infoNavigationController,
        ]

    }

    
}

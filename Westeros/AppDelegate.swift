//
//  AppDelegate.swift
//  Westeros
//
//  Created by Alexandre Freire on 25/12/2017.
//  Copyright © 2017 Westeros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splitViewController: UISplitViewController!
    var seasonDetailViewController: SeasonDetailViewController!
    var houseDetailViewController: HouseDetailViewController!
    var houseListNavigation: UINavigationController!
    var seasonListNavigation: UINavigationController!
    
    var houseDetailNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Crear Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .cyan
        
        // Creamos unos modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
       // Creamos los controladores
        let houseListViewController = HouseListViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asignamos delegados
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListViewController.delegate = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
        } else {
            houseListViewController.delegate = houseListViewController
            seasonListViewController.delegate = seasonListViewController
        }
        
        // Creamos los navigations
        houseListNavigation = houseListViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        // Creamos el UITabBarController
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [houseListNavigation, seasonListNavigation]
        tabBarController.delegate = self
        // Creamos el UISplitViewController y le asignamos los viewControllers
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController,houseDetailNavigation,seasonDetailNavigation]
        
        tabBarController.title = "Westeros"
        [houseDetailViewController, seasonDetailViewController].forEach {
            $0.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        }

        // Asignamos el RootVC
        window?.rootViewController = splitViewController
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }
        
        let detailNavigation: UINavigationController
        if type(of: viewController ) == SeasonListViewController.self {
            detailNavigation = seasonDetailNavigation
        } else {
            detailNavigation = houseDetailNavigation
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController.showDetailViewController(detailNavigation, sender: nil)
        }
    }
}

//
//  ViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 26/05/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Home"
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc2.title = "Coming Soon"
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.title = "Top Search"
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }


}


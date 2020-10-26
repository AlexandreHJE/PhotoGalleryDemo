//
//  RootViewController.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/26.
//

import UIKit

class RootViewController: UITabBarController {
    
    let searchPageVC = SearchPageViewController()
    let favoritePageVC = FavoritePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchPageVC.tabBarItem.title = "搜尋圖片"
        
        favoritePageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritePageVC.tabBarItem.title = "圖片收藏"
        
        viewControllers = [UINavigationController(rootViewController: searchPageVC),
            UINavigationController(rootViewController: favoritePageVC)]
        
    }
}

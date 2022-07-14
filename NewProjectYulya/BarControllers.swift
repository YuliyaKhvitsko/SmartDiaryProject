//
//  BarControllers.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 13.07.22.
//

import Foundation
import UIKit

class BarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }
    
    private func setupControllers() {
        let mainVC = NewsViewController(nibName: String(describing: NewsViewController.self), bundle: nil)
        let mainSVC = UINavigationController(rootViewController: mainVC)
        mainVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let otherVC = CalendarViewController(nibName: String(describing: CalendarViewController.self), bundle: nil)
        let otherSVC = UINavigationController(rootViewController: otherVC)
        otherVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        mainVC.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(systemName: "filemenu.and.cursorarrow"), tag: 0)


        UITabBar.appearance().tintColor = UIColor.lightGray
       

        otherVC.tabBarItem = UITabBarItem(title: "Календарь", image: UIImage(systemName: "calendar.badge.plus"), tag: 1)
        
        self.viewControllers = [mainSVC, otherSVC]
    }

}

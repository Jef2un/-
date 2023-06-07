//
//  TabBarViewController.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/5.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: MoneyViewController())
        let vc2 = UINavigationController(rootViewController: FriendViewController())
        let vc3 = UINavigationController(rootViewController: KOViewController())
        let vc4 = UINavigationController(rootViewController: BudgetingViewController())
        let vc5 = UINavigationController(rootViewController: SettingViewController())

        
        
        
        vc1.tabBarItem.image = UIImage(named: "icTabbarProductsOff")
        vc2.tabBarItem.image = UIImage(named: "icTabbarFriendsOn")
        vc3.tabBarItem.image = UIImage(named: "icTabbarHomeOff")?.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.image = UIImage(named: "icTabbarManageOff")
        vc5.tabBarItem.image = UIImage(named: "icTabbarSettingOff")

        
        

        
        
        
        tabBar.tintColor = .systemPink
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)

    }
}

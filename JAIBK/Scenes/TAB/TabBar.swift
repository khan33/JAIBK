//
//  TabBar.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.tintColor = .label
       // self.tabBar.isTranslucent = false
        //UITabBar.appearance().barTintColor = UIColor.hexStringToUIColor(hex: "#DBDBDB")
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        tabBar.clipsToBounds = true

        
        setupVCs()
    }
    
    func setupVCs() {
        
        let homeImage: UIImage! = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysOriginal)
        let cartImg: UIImage! = UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal)
        let searchImg: UIImage! = UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal)
        let shopImg: UIImage! = UIImage(named: "Shop")?.withRenderingMode(.alwaysOriginal)
        let userImg: UIImage! = UIImage(named: "userIcon")?.withRenderingMode(.alwaysOriginal)
        
        let tabOneBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImage)
        let tabTwoBarItem = UITabBarItem(title: "Shop", image: shopImg, selectedImage: shopImg)
        let tabThreeBarItem = UITabBarItem(title: "Enquire", image: searchImg, selectedImage: searchImg)
        let tabFourBarItem = UITabBarItem(title: "Cart", image: cartImg, selectedImage: cartImg)
        let tabFiveBarItem = UITabBarItem(title: "Account", image: userImg, selectedImage: userImg)
    
        let vc1 = HomeVC()
        let vc2 = ShopVC()
        let vc3 = EnquireVC()
        let vc4 = CartVC()

        
        vc1.tabBarItem = tabOneBarItem
        vc2.tabBarItem = tabTwoBarItem
        vc3.tabBarItem = tabThreeBarItem
        vc4.tabBarItem = tabFourBarItem
        
        
        let v1 = UINavigationController(rootViewController: vc1)
        let v2 = UINavigationController(rootViewController: vc2)
        let v3 = UINavigationController(rootViewController: vc3)
        let v4 = UINavigationController(rootViewController: vc4)
        
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
            let vc5 = MyAccountVC()
            vc5.tabBarItem = tabFiveBarItem
            let v5 = UINavigationController(rootViewController: vc5)
            self.viewControllers = [v1, v2, v3, v4, v5]
            self.selectedIndex = 0
        } else {
            let vc5 = LoginVC()
            vc5.tabBarItem = tabFiveBarItem
            let v5 = UINavigationController(rootViewController: vc5)
            self.viewControllers = [v1, v2, v3, v4, v5]
            self.selectedIndex = 0
        }
        
        
       
    
        
    
    }
    
}

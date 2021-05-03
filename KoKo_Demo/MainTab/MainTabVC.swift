//
//  MainTabVC.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/4/29.
//

import UIKit

enum TabBarItems: String, CaseIterable {
    case Products = "Products"
    case Friends = "Friends"
    case Home = "Home"
    case Manage = "Manage"
    case Setting = "Setting"
    
    var controller: UIViewController {
        switch self {
        case .Products:
            return ProductsVC()
        case .Friends:
            return FriendsVC()
        case .Home:
            return HomeVC()
        case .Manage:
            return ManageVC()
        case .Setting:
            return SettingVC()
        }
    }
}

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBar()
        self.configBatItems()
    }
    
    override func viewWillLayoutSubviews() {
        self.configTabbar()
    }

}

extension MainTabVC {
    
    private func configNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        let btnWithdraw = UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw")?.withRenderingMode(.alwaysOriginal),
                                          style: .plain, target: self, action: #selector(self.onClickWithdrawBtn))
        let btnTransfer = UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer")?.withRenderingMode(.alwaysOriginal),
                                          style: .plain, target: self, action: #selector(self.onClickTransferBtn))
        let btScan = UIBarButtonItem(image: UIImage(named: "icNavPinkScan")?.withRenderingMode(.alwaysOriginal),
                                     style: .plain, target: self, action: #selector(self.onClickScanBtn))
        self.navigationItem.setLeftBarButtonItems([btnWithdraw, btnTransfer], animated: false)
        self.navigationItem.setRightBarButtonItems([btScan], animated: false)
    }
    
    private func configTabbar() {
        self.tabBar.isTranslucent = false
        
        if let image = UIImage(named: "imgTabbarBg") {
            self.tabBar.backgroundImage = UIImage()
            self.tabBar.shadowImage = UIImage()
            let tabBarImageView = UIImageView(image: image)
            tabBarImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: image.size.height)
            self.tabBar.addSubview(tabBarImageView)
            self.tabBar.sendSubviewToBack(tabBarImageView)
            
        }
        
        self.tabBar.layoutIfNeeded()
    }
    
    private func configBatItems() {
        
        var controllers: [UIViewController] = []
        for selection in TabBarItems.allCases {
            let vc = selection.controller
            let image = UIImage(named: "icTabbar\(selection.rawValue)Off")?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named: "icTabbar\(selection.rawValue)On")?.withRenderingMode(.alwaysOriginal)
            let tabItem = UITabBarItem(title: nil,
                                       image: image,
                                       selectedImage: selectedImage)
            
            if selection == .Home {
                tabItem.imageInsets.top = 14
                tabItem.imageInsets.bottom = -14
            }else {
                tabItem.imageInsets.top = 19
                tabItem.imageInsets.bottom = -19
            }
            vc.tabBarItem = tabItem
            controllers.append(vc)
        }
        
        self.setViewControllers(controllers, animated: false)
        self.selectedIndex = 1
        
    }
    
    @objc private func onClickWithdrawBtn() {
        
    }
    
    @objc private func onClickTransferBtn() {
        
    }
    
    @objc private func onClickScanBtn() {
        
    }
}

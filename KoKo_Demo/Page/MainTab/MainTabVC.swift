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
        case .Friends:
            return FriendsVC()
        default:
            return UIViewController()
        }
    }
    
    var itemImage: UIImage {
        switch self {
        case .Products:
            return #imageLiteral(resourceName: "icTabbarProductsOff")
        case .Friends:
            return #imageLiteral(resourceName: "icTabbarFriendsOn")
        case .Home:
            return #imageLiteral(resourceName: "icTabbarHomeOff")
        case .Manage:
            return #imageLiteral(resourceName: "icTabbarManageOff")
        case .Setting:
            return #imageLiteral(resourceName: "icTabbarSettingOff")
        }
    }
}

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBar()
        self.configBatItems()
        self.delegate = self
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
            tabBarImageView.backgroundColor = .clear
            tabBarImageView.frame = CGRect(x: 0, y: -14, width: UIScreen.main.bounds.size.width, height: image.size.height)
            self.tabBar.addSubview(tabBarImageView)
            self.tabBar.sendSubviewToBack(tabBarImageView)
        }
        
        self.tabBar.layoutIfNeeded()
    }
    
    private func configBatItems() {
        
        var controllers: [UIViewController] = []
        for selection in TabBarItems.allCases {
            let vc = selection.controller
            let tabItem = UITabBarItem(title: nil, image: selection.itemImage.withRenderingMode(.alwaysOriginal), tag: selection.hashValue)
            if selection == .Home {
                tabItem.imageInsets.top = -3
                tabItem.imageInsets.bottom = 0
            }else {
                tabItem.imageInsets.top = 5
                tabItem.imageInsets.bottom = 0
            }
            vc.title = selection.rawValue
            if selection != .Friends {
                vc.view.backgroundColor = .gray
            }
            vc.tabBarItem = tabItem
            vc.view.frame = CGRect(origin: vc.view.frame.origin, size: CGSize(width: vc.view.frame.width, height: vc.view.frame.height + 14))
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

extension MainTabVC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.title == TabBarItems.Home.rawValue {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}

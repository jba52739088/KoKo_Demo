//
//  FirstVC.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

class FirstVC: UIViewController {
    
    private var viewModel: FirstVMInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initVC()
    }
    
    @IBAction func onClickDemoBtn(_ sender: UIButton) {
        self.viewModel?.requestApi(for: DemoType(rawValue: sender.tag) ?? .EmptyFriend, completion: { [weak self] succeed in
            if succeed {
                self?.presentMainPage()
            }
        })
    }

}

extension FirstVC {
    
    private func initVC() {
        self.viewModel = FirstVM()
    }
    
    private func onSelectedDemoType(_ type: DemoType) {
        self.presentMainPage()
    }
    
    private func presentMainPage() {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
            else { return }
//        let navVC = UINavigationController(rootViewController: mainVC)
//        navVC.setNavigationBarHidden(false, animated: false)
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
}

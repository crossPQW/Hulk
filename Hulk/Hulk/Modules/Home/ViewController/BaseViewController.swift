//
//  BaseViewController.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {

    var animatedOnNavigationBar = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else {
            return
        }
        
        navigationController.navigationBar.backgroundColor = nil
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.shadowImage = nil
        navigationController.navigationBar.barStyle = UIBarStyle.black
        navigationController.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        
        let textAttributes: [String: Any] = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17),
        ]
        
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.tintColor = nil
        
        if navigationController.isNavigationBarHidden {
            navigationController.setNavigationBarHidden(false, animated: animatedOnNavigationBar)
        }
        if navigationController.viewControllers.count > 1 {
            
            let backBtn = UIButton(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
            backBtn.setImage(UIImage(named: "left"), for: .normal)
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
            let backItem = UIBarButtonItem(customView: backBtn)
            
            let spaceitem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spaceitem.width = -10
            navigationItem.leftBarButtonItems = [spaceitem, backItem]
        }
        navigationController.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}

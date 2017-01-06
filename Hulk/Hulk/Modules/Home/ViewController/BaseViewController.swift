//
//  BaseViewController.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

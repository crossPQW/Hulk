//
//  ViewController.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/5.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let cellID = "DriverCell"
    var tableView :UITableView!
    var magnets : Array<String> = []
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchData()
    }

    func setupSubviews()  {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func fetchData() {
        Alamofire.request("https://raw.githubusercontent.com/Chion82/hello-old-driver/master/resource_list.json").responseJSON { (response) in
            var tempArray: Array<Dictionary<String, Any>> = []
            if let JSON = response.result.value {
                tempArray = JSON as! Array
                for item  in tempArray {
                    let dic = item 
                    let string = dic["title"]
                    self.magnets.append(string! as! String)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magnets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DriverCell
        cell.title.text = magnets[indexPath.row]
        
        return cell
    }
}


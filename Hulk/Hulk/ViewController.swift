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
    var magnets : Array<Resources> = []
    
    //Mark:- Services
    private var apiServer: TorrentApiProtocol = TorrentApi()
    
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
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func fetchData() {
        apiServer.fetchResources { (torrents, error) in
            self.magnets = torrents!
            self.tableView.reloadData()
        }
    }
    
    //MARK:- UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magnets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DriverCell
        let torrent = magnets[indexPath.row]
        cell.title.text = torrent.title
        
        return cell
    }
}


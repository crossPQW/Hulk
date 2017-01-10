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
import RealmSwift

class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    private let cellID = "DriverCell"
    var tableView :UITableView!
    var magnets :Results<Resources>? = nil
    var magnetsList :Array<Resources>? = []
    private let number = 20
    private var currentPage = 0
    
    //Mark:- Services
    private var apiServer: TorrentApiProtocol = TorrentApi()
    
    var refreshControl = UIRefreshControl()
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchData()
    }
    
    func setupSubviews()  {
        title = "老司机"
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        refreshControl.backgroundColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(didLoad), for: .valueChanged)
        let attr = [NSForegroundColorAttributeName: UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "updated on \(NSDate())", attributes: attr)
        refreshControl.tintColor = UIColor.lightGray
    }
    
    func fetchData() {
        let realm = try! Realm()
        magnets = realm.objects(Resources.self)
        if (magnets?.count)! > 0 {
            loadData(page: currentPage)
            tableView.reloadData()
        }else {
            apiServer.fetchResources { (resources, error) in
                self.magnets = realm.objects(Resources.self)
                self.loadData(page: self.currentPage)
                self.tableView.reloadData()
            }
        }
    }
    
    func didLoad()  {
        loadData(page: currentPage)
        currentPage = currentPage + 1
        tableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    func loadData(page: Int) {
        for i in page*number ..< (page+1)*number {
            magnetsList?.insert((magnets?[i])!, at: 0)
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
        return magnetsList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DriverCell
        let resource = magnetsList?[indexPath.row]
        cell.resources = resource
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tVc = TorrentViewController()
        let resource = magnetsList?[indexPath.row]
        tVc.resource = resource!
        navigationController?.pushViewController(tVc, animated: true)
    }
}


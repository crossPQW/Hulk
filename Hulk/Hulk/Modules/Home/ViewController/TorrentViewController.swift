//
//  TorrentViewController.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Foundation

class TorrentViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,URLSessionDelegate {

    private let cellID = "MagnetsCell"
    var resource :Resources!
    var tableview :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubveiw()
    }

    func setupSubveiw() {
        title = "全特么是种子"
        tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableview.separatorStyle = .none
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func download(urlString: String) {
        Alamofire.download(urlString).downloadProgress { (progress) in
            print(progress)
        }.responseData { (response) in
            print("response.error = \(response)")
        }
        
    }
    
    //MARK: - UITableViewDelegate UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resource.magnets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MagnetsCell
        let magnets = resource.magnets[indexPath.row]
        cell.magnets.text = magnets.torrent
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let magnets = resource.magnets[indexPath.row]
        download(urlString: magnets.torrent)
    }
}

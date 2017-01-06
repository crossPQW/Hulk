//
//  TorrentApi.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class TorrentApi: TorrentApiProtocol {
    private let url = "https://raw.githubusercontent.com/Chion82/hello-old-driver/master/resource_list.json"
    
    func fetchResources(completionHandler: @escaping TorrentCompletionHandler) {
        
        var result = Array<Resources>()
        Alamofire.request(url).responseJSON { (response) in
            var tempArray: Array<Dictionary<String, Any>> = []
            
            if let JSON = response.result.value {
                tempArray = JSON as! Array
                for (index, item) in tempArray.enumerated() {
                    let dic = item
                    let title = dic["title"]
                    let torrentStrings:Array<String> = dic["magnets"] as! Array<String>
                    
                    let realm = try! Realm()
                    //先清空数据
                    try! realm.write {
                        realm.deleteAll()
                    }
                    
                    //create Resources
                    let resource = Resources()
                    resource.title = title as! String
                    resource.ID = String(index)
                    for tor in torrentStrings {
                        let torrent = Torrent()
                        torrent.torrent = tor
                        torrent.owner = resource
                        resource.magnets.append(torrent)
                    }
                    
                    try! realm.write {
                        realm.add(resource)
                    }
                    
                    result.append(resource)
                }
            }
            
            if response.result.isSuccess {
                completionHandler(result, response.result.error)
            }
        }
    }
}

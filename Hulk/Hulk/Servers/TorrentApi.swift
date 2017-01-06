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
                for item in tempArray {
                    let dic = item
                    let title = dic["title"]
                    let torrentStrings:Array<String> = dic["magnets"] as! Array<String>
                    
                    //create Resources
                    let resource = Resources()
                    resource.title = title as! String
                    for tor in torrentStrings {
                        let torrent = Torrent()
                        torrent.torrent = tor
                        torrent.owner = resource
                        resource.magnets.append(torrent)
                    }
                    
                    result.append(resource)
                    
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(resource)
                    }
                }
            }
            
            if response.result.isSuccess {
                completionHandler(result, response.result.error)
            }
        }
    }
}

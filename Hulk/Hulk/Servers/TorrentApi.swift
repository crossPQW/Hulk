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

struct TorrentApi: TorrentApiProtocol {
    private let url = "https://raw.githubusercontent.com/Chion82/hello-old-driver/master/resource_list.json"
    
    func fetchResources(completionHandler : @escaping TorrentCompletionHandler) {
        
        var result = Array<Torrent>()
        Alamofire.request(url).responseJSON { (response) in
            var tempArray : Array<Dictionary<String, Any>> = []
            
            if let JSON = response.result.value {
                tempArray = JSON as! Array
                for item in tempArray {
                    let dic = item
                    let title = dic["title"]
                    let torrentStrings:Array<String> = dic["magnets"] as! Array<String>
                    
                    let torrent = Torrent(title : title as! String, magnets : torrentStrings)
                    result.append(torrent)
                }
            }
            completionHandler(result, response.result.error)
        }
    }
}

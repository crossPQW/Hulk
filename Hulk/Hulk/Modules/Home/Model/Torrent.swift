//
//  Torrent.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import Foundation
import RealmSwift

class Torrent: Object {
    dynamic var torrent: String = ""
    dynamic var owner: Resources? = nil
}

class Resources: Object {
    dynamic var ID = ""
    dynamic var title: String = ""
    let magnets = List<Torrent>()
    
    override static func indexedProperties() -> [String] {
        return ["ID"]
    }
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}

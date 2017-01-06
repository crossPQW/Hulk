//
//  TorrentApiProtocol.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/6.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import Foundation

typealias TorrentCompletionHandler = (Array<Resources>?, Error?) -> Void

protocol TorrentApiProtocol {
    func fetchResources(completionHandler: @escaping TorrentCompletionHandler)
}

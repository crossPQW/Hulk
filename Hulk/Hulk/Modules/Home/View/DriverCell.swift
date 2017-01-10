//
//  DriverCell.swift
//  Hulk
//
//  Created by 黄少华 on 2017/1/5.
//  Copyright © 2017年 黄少华. All rights reserved.
//

import UIKit

class DriverCell: UITableViewCell {

    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var title: UILabel!
    var resources :Resources! {
        didSet {
            index.text = resources.ID
            title.text = resources.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

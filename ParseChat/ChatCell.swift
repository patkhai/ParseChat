//
//  ChatCell.swift
//  ParseChat
//
//  Created by Pat Khai on 9/19/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    
    @IBOutlet weak var chatID: UILabel!
    
    @IBOutlet weak var chatMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

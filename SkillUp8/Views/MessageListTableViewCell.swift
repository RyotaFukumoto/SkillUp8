//
//  MessageListTableViewCell.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/07.
//  Copyright © 2018年 ryota. All rights reserved.
//

import UIKit

class MessageListTableViewCell: UITableViewCell {

    @IBOutlet weak var textV: UITextView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        textV.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

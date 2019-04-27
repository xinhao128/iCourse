//
//  PostDetailCell.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/13/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class PostDetailCell: UITableViewCell {

    @IBOutlet weak var postTag: UILabel!
    @IBOutlet weak var postedBy: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postPreview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PostCell.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/6/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var postTag: UILabel!
    @IBOutlet weak var postedBy: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postPreview: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounting: UILabel!
    
    
    @IBOutlet weak var photoViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

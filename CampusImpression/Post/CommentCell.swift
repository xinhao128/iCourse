//
//  CommentsCell.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/12/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postedBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentView.backgroundColor = UIColor(named: "CommentColor")
        commentView.layer.borderWidth = 10
        commentView.layer.cornerRadius = 10
        commentView.layer.masksToBounds = true
        commentView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

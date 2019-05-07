//
//  ClassCollectionViewCell.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

protocol ClassCellDelegate: class {
    func delete(cell: ClassCollectionViewCell)
}

class ClassCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var ClassLabel: UILabel!
    
    weak var delegate: ClassCellDelegate?
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
}

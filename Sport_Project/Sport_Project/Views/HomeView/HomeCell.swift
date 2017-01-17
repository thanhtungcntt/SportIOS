//
//  HomeCell.swift
//  Sport_Project
//
//  Created by Thanh Tùng on 1/15/17.
//  Copyright © 2017 AllAboutSport. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var vContaint: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vContaint.backgroundColor = ColorUtil.colorBlackAlpha
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

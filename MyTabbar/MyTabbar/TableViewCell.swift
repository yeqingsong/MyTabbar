//
//  TableViewCell.swift
//  MyTabbar
//
//  Created by shoule on 16/6/2.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var sec1Image1: UIImageView!
    
    @IBOutlet weak var sec2Image1: UIImageView!
    @IBOutlet weak var sec2Image2: UIImageView!
    @IBOutlet weak var sec2Size1: UILabel!
    @IBOutlet weak var sec2Size2: UILabel!
    @IBOutlet weak var sec2Name1: UILabel!
    @IBOutlet weak var sec2Name2: UILabel!
    @IBOutlet weak var sec2upImage1: UIImageView!
    @IBOutlet weak var sec2upImage2: UIImageView!
    @IBOutlet weak var sec2Image3: UIImageView!
    @IBOutlet weak var sec2Size3: UILabel!
    @IBOutlet weak var sec2Name3: UILabel!
    @IBOutlet weak var sec2Kouwei: UILabel!
    @IBOutlet weak var sec2sweet: UILabel!

    @IBOutlet weak var sec3Image1: UIImageView!
    @IBOutlet weak var sec3Size: UILabel!
    @IBOutlet weak var sec3Name: UILabel!
    @IBOutlet weak var sec3Kouwei: UILabel!
    @IBOutlet weak var sec3Sweet: UILabel!
    
    
    @IBOutlet weak var comboImage1: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

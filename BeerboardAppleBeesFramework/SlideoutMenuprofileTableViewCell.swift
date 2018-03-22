//
//  SlideoutMenuprofileTableViewCell.swift
//  Slidemenu
//
//  Created by Vmoksha on 19/03/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

class SlideoutMenuprofileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageview: UIImageView!
    
    
    @IBOutlet weak var profileNameLbl: UILabel!
    
    @IBOutlet weak var profileSubtitleLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

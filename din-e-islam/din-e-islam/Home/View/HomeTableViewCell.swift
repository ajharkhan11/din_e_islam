//
//  HomeTableViewCell.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 27/09/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titile: UILabel!
    
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

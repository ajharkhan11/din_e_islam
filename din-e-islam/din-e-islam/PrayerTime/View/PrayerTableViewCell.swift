//
//  PrayerTableViewCell.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 27/09/22.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {
    @IBOutlet weak var prayerName: UILabel!
    
    @IBOutlet weak var prayerTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickNotification(_ sender: UIButton) {
        
    }
    
}

//
//  TableViewCell.swift
//  my-App
//
//  Created by User on 30.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleOfLabel: UILabel!
    @IBOutlet weak var contentOfLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

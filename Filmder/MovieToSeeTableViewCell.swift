//
//  MovieToSeeTableViewCell.swift
//  Filmder
//
//  Created by MacNicolas on 11/01/2019.
//  Copyright © 2019 civetdelapin. All rights reserved.
//

import UIKit

class MovieToSeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toSeeImageView: UIImageView!
    @IBOutlet weak var toSeeTitle: UILabel!
    @IBOutlet weak var toSeeDateText: UILabel!
    
    @IBOutlet weak var toSeeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

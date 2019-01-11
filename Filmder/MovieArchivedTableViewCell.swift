//
//  MovieArchivedTableViewCell.swift
//  Filmder
//
//  Created by MacNicolas on 11/01/2019.
//  Copyright © 2019 civetdelapin. All rights reserved.
//

import UIKit

class MovieArchivedTableViewCell: UITableViewCell {
    @IBOutlet weak var archivedImageView: UIImageView!
    @IBOutlet weak var archivedTitle: UILabel!
    @IBOutlet weak var archivedDateText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

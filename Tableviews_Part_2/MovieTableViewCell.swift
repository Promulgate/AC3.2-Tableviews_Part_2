//
//  MovieTableViewCell.swift
//  Tableviews_Part_2
//
//  Created by Eric Chang on 9/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var moviePosterImageViewer: UIImageView!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var greenTitleBar: UILabel!
    @IBOutlet weak var bottomBorder: UILabel!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var starringCastLabel: UILabel!
    @IBOutlet weak var backgroundContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

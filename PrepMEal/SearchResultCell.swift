//
//  SearchResultCell.swift
//  PrepMEal
//
//  Created by Joanne Fung on 12/11/20.
//

import UIKit

class SearchResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!

}

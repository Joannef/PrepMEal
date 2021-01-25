//
//  SearchResultCell.swift
//  PrepMEal
//

import UIKit

class SearchResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 205/255, green: 211/255, blue: 250/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    var downloadTask: URLSessionDownloadTask?
    
    //MARK:- Public Method
    func configure(for result: Recipes) {
        recipeNameLabel.text = result.title
        calorieLabel.text = "\(String(result.nutrition.nutrients[0].amount)) \(result.nutrition.nutrients[0].unit)"
        recipeImage.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: result.image) {
          downloadTask = recipeImage.loadImage(url: smallURL)
        }
    }
}

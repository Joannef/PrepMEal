//
//  ViewController.swift
//  PrepMEal
//
//

import UIKit

class selectedResult : Codable {
    var recipe = ""
    var calories = Double()
    var unit = ""
    var image = ""
}

class DayItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var recipeName = ""
    var calorieCount = Double()
    var calorieUnit = ""
    var recipeImg = ""
    var downloadTask: URLSessionDownloadTask?
    var num = Int()

    var recipeItems = [selectedResult]()

    struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.searchResultCell)
        recipeItems = PersistencyHelper.loadRecipes()
//        print(num)
//        print(recipeName, calorieCount, calorieUnit)
//        print(recipeItems)
        for item in recipeItems {
            num += Int(item.calories)
            let vc = storyboard?.instantiateViewController(withIdentifier: "WeeklyCalendarViewController")
                as? WeeklyCalendarViewController
            vc?.calNum = num
            print("calNum is \(vc!.calNum)")
            print("\(item.recipe) \(item.calories) \(item.unit)")
            print(num)
        }
        print(recipeItems.count)
    }
        
    func addRecipe(_ recipe:String, calorie:Double, unit:String, image: String){
        let item = selectedResult()
        item.recipe = recipe
        item.calories = calorie
        item.image = image
        item.unit = unit
        
        var recipes = PersistencyHelper.loadRecipes()
        recipes.append(item)
        PersistencyHelper.saveRecipes(recipes)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
        let recipeItem = recipeItems[indexPath.row]
        let nameLabel = cell.viewWithTag(3000) as! UILabel
        let calorieLabel = cell.viewWithTag(4000) as! UILabel
        let imageView = cell.viewWithTag(5000) as! UIImageView
        nameLabel.text = recipeItem.recipe
        calorieLabel.text = String(recipeItem.calories)
        let url = URL(string: recipeItem.image)
        imageView.image = UIImage(named: "Placeholder")
        downloadTask = imageView.loadImage(url: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        recipeItems.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        PersistencyHelper.saveRecipes(recipeItems)
    }
}

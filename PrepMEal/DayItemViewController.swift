//
//  ViewController.swift
//  PrepMEal
//
//

import UIKit

class selectedResult {
    var recipe = ""
    var calories = ""
}

class DayItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var recipeName = ""
    var calorieCount = ""
    var calorieUnit = ""
    var recipeImg = ""

    var recipeItems = [selectedResult]()

    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeItems = []
        let cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        print(recipeName, calorieCount, calorieUnit)
        print(recipeItems.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
//        let recipeItem = recipeItems[indexPath.row]
        cell.recipeNameLabel.text = recipeName
        cell.calorieLabel.text = "\(calorieCount) \(calorieUnit)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

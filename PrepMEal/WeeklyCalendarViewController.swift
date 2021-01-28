//
//  WeeklyCalendarViewController.swift
//  PrepMEal
//
//

import UIKit

class WeeklyItem {
    var day = ""
    var calorie = 0
}

class WeeklyCalendarViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    
    var items = [WeeklyItem]()
    var calNum = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        print(calNum)
        let item1 = WeeklyItem()
        item1.day = "Sunday"
        item1.calorie = calNum
        items.append(item1)
        
        let item2 = WeeklyItem()
        item2.day = "Monday"
        item1.calorie = calNum
        items.append(item2)
        
        let item3 = WeeklyItem()
        item3.day = "Tuesday"
        item1.calorie = calNum
        items.append(item3)
        
        let item4 = WeeklyItem()
        item4.day = "Wednesday"
        item1.calorie = calNum
        items.append(item4)
        
        let item5 = WeeklyItem()
        item5.day = "Thursday"
        items.append(item5)
        
        let item6 = WeeklyItem()
        item6.day = "Friday"
        item1.calorie = calNum
        items.append(item6)
        
        let item7 = WeeklyItem()
        item7.day = "Saturday"
        item1.calorie = calNum
        items.append(item7)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }

    // MARK:- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyItem",
                                                 for: indexPath)
        let item = items[indexPath.row]
        
        let dayLabel = cell.viewWithTag(2000) as! UILabel
        let calorieLabel = cell.viewWithTag(1000) as! UILabel
        
        calorieLabel.text = "\(String(item.calorie)) kcal"
        dayLabel.text = item.day
        return cell
    }
    
    //MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

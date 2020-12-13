//
//  WeeklyCalendarViewController.swift
//  PrepMEal
//
//

import UIKit

class WeeklyItem {
    var day = ""
}

class WeeklyCalendarViewController: UITableViewController {
    
    var items = [WeeklyItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = WeeklyItem()
        item1.day = "Sunday"
        items.append(item1)
        
        let item2 = WeeklyItem()
        item2.day = "Monday"
        items.append(item2)
        
        let item3 = WeeklyItem()
        item3.day = "Tuesday"
        items.append(item3)
        
        let item4 = WeeklyItem()
        item4.day = "Wednesday"
        items.append(item4)
        
        let item5 = WeeklyItem()
        item5.day = "Thursday"
        items.append(item5)
        
        let item6 = WeeklyItem()
        item6.day = "Friday"
        items.append(item6)
        
        let item7 = WeeklyItem()
        item7.day = "Saturday"
        items.append(item7)
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
        
        dayLabel.text = item.day
        return cell
    }
    
    //MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

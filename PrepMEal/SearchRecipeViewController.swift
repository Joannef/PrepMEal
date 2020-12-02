//
//  SearchRecipeViewController.swift
//  PrepMEal
//
//  Created by Joanne Fung on 12/2/20.
//

import UIKit

class SearchRecipeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    @IBAction func add() {
        navigationController?.popViewController(animated: true)
    }

}

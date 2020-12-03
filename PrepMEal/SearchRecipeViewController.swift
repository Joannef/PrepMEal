//
//  SearchRecipeViewController.swift
//  PrepMEal
//
//  Created by Joanne Fung on 12/2/20.
//

import UIKit

class SearchRecipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 54, left: 0, bottom: 0, right: 0)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

}

extension SearchRecipeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The search text is: '\(searchBar.text!)'")
    }
}

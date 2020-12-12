//
//  SearchRecipeViewController.swift
//  PrepMEal
//
//  Created by Joanne Fung on 12/2/20.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 54, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
                tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [Recipes]()
    var hasSearched = false
    
    //MARK:- Helper Methods
    func recipesURL(searchText: String) -> URL {
        let urlString = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let apiURL = "https://api.spoonacular.com/recipes/complexSearch?query=\(urlString)&maxCalories=10000&addRecipeInformation=true&apiKey=29bb9b72616d4ed095d7339111a413bb&fbclid=IwAR0nj2ZGq68yIS6BRZRjPUEO4MeJZIKHoFy5u4gbdsAu0H5ywq_aMYWUzt4"
        let url = URL(string: apiURL)
        return url!
    }
    
    func searchRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        }
        catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
    func parse(data: Data) -> [Recipes] {
        do {
            let result = try JSONDecoder().decode(Result.self, from: data)
            return result.results
        }
        catch {
            print("JSON Error")
            return []
        }
    }
}

extension SearchRecipeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty{
            searchBar.resignFirstResponder()
            
            hasSearched = true
            searchResults = []
            
            let url = recipesURL(searchText: searchBar.text!)
            
            print("URL: '\(url)'")
            
            if let data = searchRequest(with: url) {
                searchResults = parse(data: data)
//                let results = parse(data: data)
                print("Got results: \(searchResults)")
            }

//            URLSession.shared.dataTask(with: (url)) { data, response, error in
//                if error == nil && data != nil {
//                    if let data = data {
//                        let recipeSearchEntry = try? JSONDecoder().decode(Result.self, from: data)
//
//                        print(recipeSearchEntry ?? "Parse Failed")
////                        searchResults = recipeSearchEntry
//                    }
//                }
//            }.resume()
            
            tableView.reloadData()
        }
        print("The search text is: '\(searchBar.text!)'")
        print("Search Results is: '\(searchResults)'")
    }
}

extension SearchRecipeViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell

        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
//            let searchResult = searchResults[indexPath.row]
//            cell.recipeNameLabel.text = searchResults
//            cell.calorieLabel.text = searchResults
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

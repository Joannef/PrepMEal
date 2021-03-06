//
//  SearchRecipeViewController.swift
//  PrepMEal
//
//

import UIKit
import AVFoundation

class SearchRecipeViewController: UIViewController {
    
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
            static let loadingCell = "LoadingCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 54, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [Recipes]()
    var hasSearched = false
    var isLoading = false
    var dataTask: URLSessionDataTask?
    var audio: AVAudioPlayer?
    
    //MARK:- Helper Methods
    func recipesURL(searchText: String) -> URL {
        let urlString = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let apiURL = "https://api.spoonacular.com/recipes/complexSearch?query=\(urlString)&maxCalories=10000&addRecipeInformation=true&apiKey=dbedb221887542bdbd0cf942f9374988"
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
    
    func notifSound() {
        let url = Bundle.main.url(forResource: "notification_tune", withExtension: "mp3")
        
        do {
            try audio = AVAudioPlayer(contentsOf: url!)
        } catch {
            print(error)
        }
        
        audio?.play()
    }
}

extension SearchRecipeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty{
            notifSound()
            searchBar.resignFirstResponder()
            dataTask?.cancel()
            isLoading = true
            tableView.reloadData()
            
            hasSearched = true
            searchResults = []
            
            let url = recipesURL(searchText: searchBar.text!)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error as NSError?, error.code == -999{
                    return
//                    print("Failure! \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let data = data {
                        self.searchResults = self.parse(data: data)
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.tableView.reloadData()
                            print("Search Results is: \(self.searchResults)")
                        }
                        return
                    }
                } else {
                    print("Failure! \(response!)")
                }
                DispatchQueue.main.async {
                  self.hasSearched = false
                  self.isLoading = false
                  self.tableView.reloadData()
                }
            })
            dataTask?.resume()
 
            tableView.reloadData()
        }
//        print("The search text is: '\(searchBar.text!)'")
        
    }
}

extension SearchRecipeViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        } else if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        } else {
            if searchResults.count == 0 {
                return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
                let searchResult = searchResults[indexPath.row]
                cell.configure(for: searchResult)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DayItemViewController")
            as? DayItemViewController
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.popViewController(animated: true)
        vc?.recipeName = searchResults[indexPath.row].title
        vc?.calorieCount = searchResults[indexPath.row].nutrition.nutrients[0].amount
        vc?.calorieUnit = searchResults[indexPath.row].nutrition.nutrients[0].unit
        vc?.recipeImg = searchResults[indexPath.row].image
        vc?.addRecipe(vc!.recipeName, calorie: vc!.calorieCount, unit: vc!.calorieUnit, image: vc!.recipeImg)
        print(vc!.recipeItems)
        print(vc!.recipeItems.count)
        print(vc!.recipeName)
        print(vc!.calorieCount, vc!.calorieUnit)
        print(vc!.recipeImg)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
}

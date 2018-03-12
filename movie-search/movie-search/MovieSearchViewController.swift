//
//  MovieSearchViewController.swift
//  movie-search
//
//  Created by Carlos Arenas on 3/11/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var apiHandler = ApiHandler()
    
    private var searchTerms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("SEARCHING FOR: \(String(describing: searchBar.text))")
        performSearch(for: searchBar.text)
    }
    
    func saveSearchTerm(_ term: String) {
        if self.searchTerms.contains(term) {
            return
        }
        
        searchTerms.insert(term, at: 0)
        searchTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
    }
    
    func performSearch(for term: String?) {
        guard let term = term else { return }
        
        activityIndicator.startAnimating()
        
        apiHandler.performSearch(for: term) { movieData in
            self.activityIndicator.stopAnimating()
            
            if let movieData = movieData {
                self.saveSearchTerm(term)
                print("Result \(movieData)")
                // self.performSegue(withIdentifier: "MovieDetailSegue", sender: DefinitionSegueContext(definition: definition))
            } else {
                self.shwoNoSearchAlert(for: term)
            }
        }
    }
    
    func shwoNoSearchAlert(for term: String) {
        let alertController = UIAlertController(title: "Error", message: "No movies could be found for \(term). Try searching for something else)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = searchTerms[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSearch(for: searchTerms[indexPath.row])
    }
}


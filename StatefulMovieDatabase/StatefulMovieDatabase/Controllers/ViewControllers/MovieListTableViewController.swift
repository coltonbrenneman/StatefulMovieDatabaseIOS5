//
//  MovieListTableViewController.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var topLevelDictionary: TopLevelDictionary?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topLevelDictionary?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        guard let movies = topLevelDictionary else { return UITableViewCell() }
        let movieDict = movies.movies[indexPath.row]
        cell.updateView(movie: movieDict)
        
        return cell
    }
    
} // End of class

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        NetworkingController().fetch(endpoint: "movie", with: searchTerm) { [weak self] result in
            switch result {
            case .success(let topLevelDictionary):
                DispatchQueue.main.async {
                    self?.topLevelDictionary = topLevelDictionary
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
        searchBar.resignFirstResponder()
    }
} //End of extension

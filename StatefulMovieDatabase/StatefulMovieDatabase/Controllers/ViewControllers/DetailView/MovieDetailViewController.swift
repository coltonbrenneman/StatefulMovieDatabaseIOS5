//
//  MovieDetailViewController.swift
//  StatefulMovieDatabase
//
//  Created by Colton Brenneman on 6/23/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieBudgetLabel: UILabel!
    @IBOutlet weak var movieRevenueLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    // MARK: - Properties
    var movieDetailSentViaSegue: MovieDetailDict? {
        didSet { // Property observor ; it won't use our updateViews func until the movieDetailSentViaSgue is sent
            updateViews()
        }
    }
    var movieImageSentViaSegua: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let unWrappedMovieDetailDict = movieDetailSentViaSegue,
              let unWrappedMovieImage = movieImageSentViaSegua else { return }
        
        DispatchQueue.main.async {
            self.movieTitleLabel.text = unWrappedMovieDetailDict.title
            self.movieTaglineLabel.text = unWrappedMovieDetailDict.tagline
            self.movieBudgetLabel.text = "Budget: \(unWrappedMovieDetailDict.budget)"
            self.movieRevenueLabel.text = "Revenue: \(unWrappedMovieDetailDict.revenue)"
            self.movieRuntimeLabel.text = "Runtime: \(unWrappedMovieDetailDict.runtime) minutes"
            self.moviePopularityLabel.text = "Movie Popularity: \(unWrappedMovieDetailDict.popularity)"
            self.movieOverviewLabel.text = unWrappedMovieDetailDict.overview
            self.moviePosterImageView.image = unWrappedMovieImage
        }
    }
} // End of class

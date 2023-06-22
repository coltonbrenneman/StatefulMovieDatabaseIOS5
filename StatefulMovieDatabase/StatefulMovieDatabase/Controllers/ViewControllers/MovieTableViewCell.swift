//
//  MovieTableViewCell.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
    }
    
    // MARK: - Functions
    func updateView(movie: Movie) {
        fetchImage(movie: movie)
    }
    
    func fetchImage(movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        NetworkingController().fetchImage(with: posterPath) { result in
            switch result {
            case .success(let poster):
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = poster
                    self.movieTitleLabel.text = movie.movieName
                    self.movieRatingLabel.text = "Movie Rating: \(movie.movieRating)"
                    self.movieDescriptionLabel.text = movie.movieDescription
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
} //End of class

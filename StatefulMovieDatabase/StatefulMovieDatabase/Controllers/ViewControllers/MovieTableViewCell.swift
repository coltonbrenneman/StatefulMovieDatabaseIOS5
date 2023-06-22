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
    
    func updateView() {
        //TODO: - Update the Strings with the real values
        var configuration = defaultContentConfiguration()
        configuration.text = "What's love got to do with it?"
        configuration.secondaryText = "Whats love but a second hand emotion"
        configuration.secondaryTextProperties.numberOfLines = 4
        configuration.imageProperties.maximumSize = CGSize(width: 50, height: 100)
        contentConfiguration = configuration
    }
    
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        // Called when the image is set
        super.updateConfiguration(using: state)
        guard var configuration = contentConfiguration as? UIListContentConfiguration else { return }
        configuration.image = self.image
        contentConfiguration = configuration
    }
}

// MARK: - Functions


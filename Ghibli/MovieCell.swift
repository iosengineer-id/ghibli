//
//  MovieCell.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
 
    func setup(movie: Movie) {
        movieTitleLabel.text = movie.title
        descriptionLabel.text = movie.description
        directorLabel.text = "Director : \(movie.director)"
        yearLabel.text = "Year : \(movie.releaseYear)"
    }
    
}

//
//  MovieDetailController.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/14/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    let movieImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let movieVoteCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let moviePopularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let movieVoteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var moviePosterPath: String! {
        didSet {
            let baseUrl = IMAGE_BASE_URL + moviePosterPath
            self.movieImageView.loadImage(urlString: baseUrl)
        }
    }
    
    var movieTitle: String! {
        didSet {
            titleLabel.text = movieTitle
        }
    }
    
    var movieOverview: String! {
        didSet {
            movieOverviewLabel.text = movieOverview
        }
    }
    
    var movieVoteCount: Int32! {
        didSet {
            movieVoteCountLabel.text = "\(movieVoteCount!)"
        }
    }
    
    var moviePopularity: Double! {
        didSet {
            moviePopularityLabel.text = "\(moviePopularity!)"
        }
    }
    
    var movieVoteAverage: Double! {
        didSet {
            movieVoteAverageLabel.text = "\(movieVoteAverage!)"
        }
    }
    
    var movieReleaseDate: String! {
        didSet {
            movieReleaseDateLabel.text = "\(movieReleaseDate!)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(movieImageView)
        movieImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: movieImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(movieOverviewLabel)
        movieOverviewLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(movieVoteCountLabel)
        movieVoteCountLabel.anchor(top: movieOverviewLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(moviePopularityLabel)
        moviePopularityLabel.anchor(top: movieVoteCountLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(movieVoteAverageLabel)
        movieVoteAverageLabel.anchor(top: moviePopularityLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(movieReleaseDateLabel)
        movieReleaseDateLabel.anchor(top: movieVoteAverageLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        
        
    }
    
}

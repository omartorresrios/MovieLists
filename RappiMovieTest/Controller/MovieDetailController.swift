//
//  MovieDetailController.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/14/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let movieImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = baseUIColor
        return label
    }()
    
    let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = baseTextColor
        return label
    }()
    
    let movieVoteCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let moviePopularityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let movieVoteAverageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
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
            titleLabel.text = movieTitle.uppercased()
        }
    }
    
    var movieOverview: String! {
        didSet {
            movieOverviewLabel.text = movieOverview
        }
    }
    
    var movieVoteCount: Int32! {
        didSet {
            let attributedText = NSMutableAttributedString(string: "Vote: ", attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            
            attributedText.append(NSAttributedString(string: "\(movieVoteCount!)" , attributes: [NSAttributedStringKey.font: titleValueFont, NSAttributedStringKey.foregroundColor: baseTextColor]))
            
            movieVoteCountLabel.attributedText = attributedText
        }
    }
    
    var moviePopularity: Double! {
        didSet {
            let attributedText = NSMutableAttributedString(string: "Popularity: ", attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            
            attributedText.append(NSAttributedString(string: "\(moviePopularity!)" , attributes: [NSAttributedStringKey.font: titleValueFont, NSAttributedStringKey.foregroundColor: baseTextColor]))
            
            moviePopularityLabel.attributedText = attributedText
        }
    }
    
    var movieVoteAverage: Double! {
        didSet {
            let attributedText = NSMutableAttributedString(string: "Vote average: ", attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            
            attributedText.append(NSAttributedString(string: "\(movieVoteAverage!)" , attributes: [NSAttributedStringKey.font: titleValueFont, NSAttributedStringKey.foregroundColor: baseTextColor]))
            
            movieVoteAverageLabel.attributedText = attributedText
        }
    }
    
    var movieReleaseDate: String! {
        didSet {
            let attributedText = NSMutableAttributedString(string: "Release date: ", attributes: [NSAttributedStringKey.font: titleFont, NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            
            attributedText.append(NSAttributedString(string: "\(movieReleaseDate!)" , attributes: [NSAttributedStringKey.font: titleValueFont, NSAttributedStringKey.foregroundColor: baseTextColor]))
            
            movieReleaseDateLabel.attributedText = attributedText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = baseUIColor
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(movieImageView)
        movieImageView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
        
        movieImageView.addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: movieImageView.leftAnchor, bottom: nil, right: movieImageView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        titleLabel.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor).isActive = true
        titleLabel.textDropShadow()
        
        scrollView.addSubview(movieOverviewLabel)
        movieOverviewLabel.anchor(top: movieImageView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        scrollView.addSubview(movieVoteCountLabel)
        movieVoteCountLabel.anchor(top: movieOverviewLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        scrollView.addSubview(moviePopularityLabel)
        moviePopularityLabel.anchor(top: movieVoteCountLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        scrollView.addSubview(movieVoteAverageLabel)
        movieVoteAverageLabel.anchor(top: moviePopularityLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        scrollView.addSubview(movieReleaseDateLabel)
        movieReleaseDateLabel.anchor(top: movieVoteAverageLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
    }
    
}

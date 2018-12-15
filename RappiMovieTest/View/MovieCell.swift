//
//  MovieCell.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/12/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class MovieCell: BaseCell {
    
    var movie: PopularMovie? {
        didSet {
            self.titleLabel.text = movie?.title
            self.popularityLabel.text = "\(movie?.popularity)"
            self.voteAverageLabel.text = "\(movie?.vote_average)"
            self.voteCountLabel.text = "\(movie?.vote_count)"
            
            if let url = movie?.poster_path {
                let baseUrl = self.IMAGE_BASE_URL + url
                self.movieImageView.loadImage(urlString: baseUrl)// .loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
    }
    
    let movieImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 80
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let popularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let voteCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(movieImageView)
        movieImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: movieImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(popularityLabel)
        popularityLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(voteAverageLabel)
        voteAverageLabel.anchor(top: (popularityLabel).bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(voteCountLabel)
        voteCountLabel.anchor(top: voteAverageLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
    }
    
    let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"

//    func setMovieCellWith(movie: Movie) {
//        DispatchQueue.main.async {
//
//            self.titleLabel.text = movie.title
//            self.popularityLabel.text = "\(movie.popularity)"
//            self.voteAverageLabel.text = "\(movie.vote_average)"
//            self.voteCountLabel.text = "\(movie.vote_count)"
//
//            if let url = movie.poster_path {
//                let baseUrl = self.IMAGE_BASE_URL + url
//                self.movieImageView.loadImage(urlString: baseUrl)// .loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
//            }
//        }
//    }

}

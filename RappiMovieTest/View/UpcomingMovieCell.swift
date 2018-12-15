//
//  UpcomingMovieCell.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/14/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class UpcomingMovieCell: BaseCell {
    
    var movie: UpcomingMovie? {
        didSet {
            if let title = movie?.title {
                self.titleLabel.text = title
            }
            
            if let popularity = movie?.popularity {
                self.popularityLabel.text = "\(popularity)"
            }
            
            if let voteAverage = movie?.vote_average {
                self.voteAverageLabel.text = "\(voteAverage)"
            }
            
            if let voteCount = movie?.vote_count {
                self.voteCountLabel.text = "\(voteCount)"
            }
            
            if let url = movie?.poster_path {
                let baseUrl = IMAGE_BASE_URL + url
                self.movieImageView.loadImage(urlString: baseUrl)
            }
        }
    }
    
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
    
}


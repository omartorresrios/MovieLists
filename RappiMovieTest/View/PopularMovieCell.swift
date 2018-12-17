//
//  PopularMovieCell.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/12/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class PopularMovieCell: BaseCell {
    
    var movie: PopularMovie? {
        didSet {
            if let title = movie?.title {
                self.titleLabel.text = title
            }
            
            if let overview = movie?.overview {
                self.overviewLabel.text = overview
            }
            
            if let popularity = movie?.popularity {
                
                let attributedText = NSMutableAttributedString(string: "Popularity: ", attributes: [NSAttributedStringKey.font: popularityFont, NSAttributedStringKey.foregroundColor: UIColor.darkGray])
                
                attributedText.append(NSAttributedString(string: "\(popularity)" , attributes: [NSAttributedStringKey.font: popularityValueFont, NSAttributedStringKey.foregroundColor: UIColor.gray]))
                
                self.popularityLabel.attributedText = attributedText
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
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let popularityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(movieImageView)
        movieImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 110, height: 160)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: movieImageView.topAnchor, left: movieImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(overviewLabel)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: movieImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(popularityLabel)
        popularityLabel.anchor(top: overviewLabel.bottomAnchor, left: movieImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
    }

}

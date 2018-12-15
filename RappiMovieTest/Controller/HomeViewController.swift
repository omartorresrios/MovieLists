//
//  HomeViewController.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/11/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Locksmith

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedCellDelegate, TopRatedCellDelegate, UpcomingCellDelegate {
    
    let popularCellId = "popularCellId"
    let topRatedCellId = "topRatedCellId"
    let upcomingCellId = "upcomingCellId"
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .done, target: self, action: #selector(handleLogout))
        
        setupMenuBar()
        setupCollectionView()
        checkLogin()
        
    }
    
    private func setupMenuBar() {
        let navigationBarHeight = (navigationController?.navigationBar.frame.height)! + 20
        view.addSubview(menuBar)
        menuBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: navigationBarHeight, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: popularCellId)
        collectionView?.register(TopRatedCell.self, forCellWithReuseIdentifier: topRatedCellId)
        collectionView?.register(UpComingCell.self, forCellWithReuseIdentifier: upcomingCellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    func checkLogin() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "userLoggedIn") == nil {
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func didTapToMovieDetail(title: String, overview: String, voteCount: Int32, popularity: Double, voteAverage: Double, releaseDate: String, posterPath: String) {
        let movieDetailController = MovieDetailController()
        movieDetailController.movieTitle = title
        movieDetailController.movieOverview = overview
        movieDetailController.movieVoteCount = voteCount
        movieDetailController.moviePopularity = popularity
        movieDetailController.movieVoteAverage = voteAverage
        movieDetailController.movieReleaseDate = releaseDate
        movieDetailController.moviePosterPath = posterPath
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularCellId, for: indexPath) as! FeedCell
            cell.feedCellDelegate = self
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topRatedCellId, for: indexPath) as! TopRatedCell
            cell.topRatedCellDelegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingCellId, for: indexPath) as! UpComingCell
            cell.upcomingCellDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @objc func handleLogout() {
        clearLoggedinFlagInUserDefaults()
        clearAPITokensFromKeyChain()
        
        DispatchQueue.main.async {
            let loginController = LoginController()
            let navController = UINavigationController(rootViewController: loginController)
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    // Clear the NSUserDefaults flag
    func clearLoggedinFlagInUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userLoggedIn")
        defaults.synchronize()
    }
    
    // Clear API Auth token from Keychain
    func clearAPITokensFromKeyChain() {
        // clear API Auth Token
        try! Locksmith.deleteDataForUserAccount(userAccount: "AuthToken")
        try! Locksmith.deleteDataForUserAccount(userAccount: "currentUserId")
        try! Locksmith.deleteDataForUserAccount(userAccount: "currentUserName")
    }
}

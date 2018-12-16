//
//  HomeViewController.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/11/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Locksmith

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, PopularCellDelegate, TopRatedCellDelegate, UpcomingCellDelegate {
    
    let popularCellId = "popularCellId"
    let topRatedCellId = "topRatedCellId"
    let upcomingCellId = "upcomingCellId"
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "logout"), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Busca películas"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        setupMenuBar()
        setupNavBar()
        setupCollectionView()
        checkLogin()
    }
    
    func setupNavBar() {
        let navBar = navigationController?.navigationBar
        
        navigationController?.navigationBar.addSubview(logoutButton)
        logoutButton.anchor(top: nil, left: nil, bottom: nil, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 30, height: 30)
        logoutButton.centerYAnchor.constraint(equalTo: (navBar?.centerYAnchor)!).isActive = true
        
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: logoutButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView?.contentInsetAdjustmentBehavior = .never
        
        collectionView?.register(PopularCell.self, forCellWithReuseIdentifier: popularCellId)
        collectionView?.register(TopRatedCell.self, forCellWithReuseIdentifier: topRatedCellId)
        collectionView?.register(UpComingCell.self, forCellWithReuseIdentifier: upcomingCellId)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func didTapToMovieDetail(title: String, overview: String, voteCount: Int32, popularity: Double, voteAverage: Double, releaseDate: String, posterPath: String) {
        searchBar.isHidden = true
        searchBar.endEditing(true)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularCellId, for: indexPath) as! PopularCell
            cell.popularCellDelegate = self
            searchBar.delegate = cell
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topRatedCellId, for: indexPath) as! TopRatedCell
            cell.topRatedCellDelegate = self
            searchBar.delegate = cell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingCellId, for: indexPath) as! UpComingCell
            cell.upcomingCellDelegate = self
            searchBar.delegate = cell
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

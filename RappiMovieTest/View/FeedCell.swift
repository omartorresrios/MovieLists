//
//  PopularCell.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/12/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import CoreData

protocol FeedCellDelegate {
    func didTapToMovieDetail(title: String, overview: String, voteCount: Int32, popularity: Double, voteAverage: Double, releaseDate: String, posterPath: String)
}

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
    var feedCellDelegate: FeedCellDelegate?
    let cellId = "cellId"
    var blockOperations: [BlockOperation] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: "PopularMovie"))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "popularity", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func setupViews() {
        super.setupViews()
        setupCollectionView()
        fetchMovies()
    }
    
    deinit {
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    func fetchMovies() {
        performFetch()
        ApiService.instance.fetchPopularMovies { (movies) in
            CoreDataStack.instance.saveInCoreDataWith(number: 1, array: movies)
        }
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .yellow
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            fetchedhResultController.fetchRequest.predicate = nil
            performFetch()
        } else {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "title contains[c] '\(searchText)'")
            fetchedhResultController.fetchRequest.predicate = predicate
            performFetch()
        }
        collectionView.reloadData()
    }
    
    func performFetch() {
        do {
            try self.fetchedhResultController.performFetch()
        } catch {
            print("Error fetching result controller")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView.insertItems(at: [newIndexPath!])
                    }
                })
            )
        case .delete:
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView.deleteItems(at: [indexPath!])
                    }
                })
            )
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({ () -> Void in
            for operation: BlockOperation in self.blockOperations {
                operation.start()
            }
        }, completion: { (finished) -> Void in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PopularMovieCell
        if let movie = fetchedhResultController.object(at: indexPath) as? PopularMovie {
            cell.movie = movie
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 380)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = fetchedhResultController.object(at: indexPath) as? PopularMovie {
            let title = movie.title
            let posterPath = movie.poster_path
            let overview = movie.overview
            let voteCount = movie.vote_count
            let popularity = movie.popularity
            let voteAverage = movie.vote_average
            let releaseDate = movie.release_date
            
            feedCellDelegate?.didTapToMovieDetail(title: title!, overview: overview!, voteCount: voteCount, popularity: popularity, voteAverage: voteAverage, releaseDate: releaseDate!, posterPath: posterPath!)
        }
    }
}


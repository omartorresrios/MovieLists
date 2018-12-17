//
//  CoreDataStack.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/12/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    static let instance = CoreDataStack()
    
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RappiMovieTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func performFetch(frc: NSFetchedResultsController<NSFetchRequestResult>) {
        do {
            try frc.performFetch()
        } catch {
            print("Error fetching result controller")
        }
    }
    
    private func createMovieEntityFrom(entity: String, entityName: String, dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.instance.persistentContainer.viewContext
        
        if entity == EntityName.popularMovie.rawValue {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! PopularMovie
            model.title = dictionary["title"] as? String ?? ""
            model.overview = dictionary["overview"] as? String ?? ""
            model.release_date = dictionary["release_date"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        } else if entity == EntityName.topRatedMovie.rawValue {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! TopRatedMovie
            model.title = dictionary["title"] as? String ?? ""
            model.overview = dictionary["overview"] as? String ?? ""
            model.release_date = dictionary["release_date"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        } else {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! UpcomingMovie
            model.title = dictionary["title"] as? String ?? ""
            model.overview = dictionary["overview"] as? String ?? ""
            model.release_date = dictionary["release_date"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        }
    }
    
    func saveInCoreDataWith(entity: String, array: [[String: AnyObject]]) {
        if entity == EntityName.popularMovie.rawValue {
            _ = array.map{self.createMovieEntityFrom(entity: EntityName.popularMovie.rawValue, entityName: "PopularMovie", dictionary: $0)}
        } else if entity == EntityName.topRatedMovie.rawValue {
            _ = array.map{self.createMovieEntityFrom(entity: EntityName.topRatedMovie.rawValue, entityName: "TopRatedMovie", dictionary: $0)}
        } else {
            _ = array.map{self.createMovieEntityFrom(entity: EntityName.upcomingMovie.rawValue, entityName: "UpcomingMovie", dictionary: $0)}
        }
        
        do {
            try CoreDataStack.instance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
}

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
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "RappiMovieTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            print("document url: ", url)
            
        }
    }
    
    private func createMovieEntityFrom(number: Int, entityName: String, dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.instance.persistentContainer.viewContext
        
        
        if number == 1 {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! PopularMovie
            model.title = dictionary["title"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        } else if number == 2 {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! TopRatedMovie
            model.title = dictionary["title"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        } else {
            let model = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! UpcomingMovie
            model.title = dictionary["title"] as? String ?? ""
            model.popularity = dictionary["popularity"] as? Double ?? 0
            model.poster_path = dictionary["poster_path"] as? String ?? ""
            model.vote_average = dictionary["vote_average"] as? Double ?? 0
            model.vote_count = dictionary["vote_count"] as? Int32 ?? 0
            return model
        }
        
        
    }
    
    func saveInCoreDataWith(number: Int, array: [[String: AnyObject]]) {
        if number == 1 {
            _ = array.map{self.createMovieEntityFrom(number: 1, entityName: "PopularMovie", dictionary: $0)}
        } else if number == 2 {
            _ = array.map{self.createMovieEntityFrom(number: 2, entityName: "TopRatedMovie", dictionary: $0)}
        } else {
            _ = array.map{self.createMovieEntityFrom(number: 3, entityName: "UpcomingMovie", dictionary: $0)}
        }
        
        do {
            try CoreDataStack.instance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
}

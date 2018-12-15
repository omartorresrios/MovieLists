//
//  ApiService.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/13/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith
import CoreData

class ApiService: NSObject {
    
    static let instance = ApiService()
    
    func fetchPopularMovies(completion: @escaping ([[String : AnyObject]]) -> ()) {
        fetchFeedForUrlString(urlString: BASE_URL + GET_POPULAR_MOVIES_URL + parameters, entityName: popularMovie, completion: completion)
    }
    
    func fetchTopRatedMovies(completion: @escaping ([[String : AnyObject]]) -> ()) {
        fetchFeedForUrlString(urlString: BASE_URL + GET_TOP_RATED_MOVIES_URL + parameters, entityName: topRatedMovie, completion: completion)
    }
    
    func fetchUpcomingMovies(completion: @escaping ([[String : AnyObject]]) -> ()) {
        fetchFeedForUrlString(urlString: BASE_URL + GET_UPCOMING_MOVIES_URL + parameters, entityName: upcomingMovie, completion: completion)
    }
    
    private func clearData(entityName: String) {
        do {
            let context = CoreDataStack.instance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.instance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func fetchFeedForUrlString(urlString: String, entityName: String, completion: @escaping ([[String : AnyObject]]) -> ()) {
        let url = URL(string: urlString)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                self.clearData(entityName: entityName)
                let responseDictionary = JSON as! NSDictionary
                let moviesArray = responseDictionary["results"] as! NSArray
                
                completion(moviesArray as! [[String : AnyObject]])
                
            case .failure(let error):
                print("The error:", error)
                return
            }
        }
    }
}


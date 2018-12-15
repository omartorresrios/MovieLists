//
//  UpcomingMovie+CoreDataProperties.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/14/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//
//

import Foundation
import CoreData


extension UpcomingMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UpcomingMovie> {
        return NSFetchRequest<UpcomingMovie>(entityName: "UpcomingMovie")
    }

    @NSManaged public var popularity: Double
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var release_date: String?
    @NSManaged public var vote_count: Int32

}

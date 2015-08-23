//
//  Record.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import Foundation
import CoreData

@objc(Record)
class Record: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var numberOfReps: NSNumber
    @NSManaged var unit: String
    @NSManaged var weight: NSNumber
    @NSManaged var movement: Movement

}

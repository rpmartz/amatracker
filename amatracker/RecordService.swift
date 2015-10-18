//
//  RecordService.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecordService {
    
    let appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    func loadRecordsByMovement(movement: Movement) -> [Record]! {
        let movementPredicate = NSPredicate(format: "movement == %@", movement)
        let request = NSFetchRequest(entityName: "Record")
        request.predicate = movementPredicate
        
        let context = appDelegate.managedObjectContext!
        
        var error: NSError?
        let fetchedRecords = (try! context.executeFetchRequest(request)) as! [Record]
        
        return fetchedRecords
        
    }
    
    func deleteRecord(record:Record) -> Void {
        let context = appDelegate.managedObjectContext!
        context.deleteObject(record)
        
        var error: NSError?
        do {
            try context.save()
        } catch let error1 as NSError {
            error = error1
        }
    }
}
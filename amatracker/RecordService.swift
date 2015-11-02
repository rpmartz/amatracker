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
        let fetchedRecords = (try! context.executeFetchRequest(request)) as! [Record]
        
        return fetchedRecords
        
    }
    
    func deleteRecord(record:Record) -> Void {
        let context = appDelegate.managedObjectContext!
        context.deleteObject(record)
        
        
        do {
            try context.save()
        } catch let error1 as NSError {
            NSLog("\(error1)")
        }
    }
}
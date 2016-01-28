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
    
    private func createTestRecords() -> Void {
        let req = NSFetchRequest(entityName: "Movement")
        
        let context = appDelegate.managedObjectContext!
        let movements = (try! context.executeFetchRequest(req)) as! [Movement]
        
        for movement in movements {
            let entityDescription = NSEntityDescription.entityForName("Record", inManagedObjectContext: context)!
            
            // earlier but more than second 1RM
            let firstOneRepMaxRecord = Record(entity: entityDescription, insertIntoManagedObjectContext: context)
            firstOneRepMaxRecord.movement = movement
            firstOneRepMaxRecord.numberOfReps = 1
            firstOneRepMaxRecord.unit = "kg"
            firstOneRepMaxRecord.weight = 100
            firstOneRepMaxRecord.date = buildDate(2015, month: 10, day: 31)
            
            
            let secondOneRM = Record(entity: entityDescription, insertIntoManagedObjectContext: context)
            secondOneRM.movement = movement
            secondOneRM.numberOfReps = 1
            secondOneRM.unit = "kg"
            secondOneRM.weight = 95
            secondOneRM.date = NSDate()
            
            let threeReps = Record(entity: entityDescription, insertIntoManagedObjectContext: context)
            threeReps.movement = movement
            threeReps.numberOfReps = 3
            threeReps.unit = "kg"
            threeReps.weight = 70
            threeReps.date = buildDate(2015, month: 11, day: 17)
            
            let fiveReps = Record(entity: entityDescription, insertIntoManagedObjectContext: context)
            fiveReps.movement = movement
            fiveReps.numberOfReps = 5
            fiveReps.unit = "kg"
            fiveReps.weight = 60
            fiveReps.date = buildDate(2014, month: 07, day: 04)
            
        }
        
        appDelegate.saveContext()
        
        
    }
    
    private func buildDate(year : Int, month : Int, day : Int) -> NSDate {
        
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
}
import Foundation
import CoreData
import UIKit

class RecordService {
    
    let appDelegate : AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    func loadRecordsByMovement(_ movement: Movement) -> [Record]! {
        let movementPredicate = NSPredicate(format: "movement == %@", movement)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        request.predicate = movementPredicate
        
        let context = appDelegate.managedObjectContext!
        let fetchedRecords = (try! context.fetch(request)) as! [Record]
        
        return fetchedRecords
        
    }
    
    func deleteRecord(_ record:Record) -> Void {
        let context = appDelegate.managedObjectContext!
        context.delete(record)
        
        
        do {
            try context.save()
        } catch let error1 as NSError {
            NSLog("\(error1)")
        }
    }
    
    fileprivate func createTestRecords() -> Void {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Movement")
        
        let context = appDelegate.managedObjectContext!
        let movements = (try! context.fetch(req)) as! [Movement]
        
        for movement in movements {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Record", in: context)!
            
            // earlier but more than second 1RM
            let firstOneRepMaxRecord = Record(entity: entityDescription, insertInto: context)
            firstOneRepMaxRecord.movement = movement
            firstOneRepMaxRecord.numberOfReps = 1
            firstOneRepMaxRecord.unit = "kg"
            firstOneRepMaxRecord.weight = 100
            firstOneRepMaxRecord.date = buildDate(2015, month: 10, day: 31)
            
            
            let secondOneRM = Record(entity: entityDescription, insertInto: context)
            secondOneRM.movement = movement
            secondOneRM.numberOfReps = 1
            secondOneRM.unit = "kg"
            secondOneRM.weight = 95
            secondOneRM.date = Date()
            
            let threeReps = Record(entity: entityDescription, insertInto: context)
            threeReps.movement = movement
            threeReps.numberOfReps = 3
            threeReps.unit = "kg"
            threeReps.weight = 70
            threeReps.date = buildDate(2015, month: 11, day: 17)
            
            let fiveReps = Record(entity: entityDescription, insertInto: context)
            fiveReps.movement = movement
            fiveReps.numberOfReps = 5
            fiveReps.unit = "kg"
            fiveReps.weight = 60
            fiveReps.date = buildDate(2014, month: 07, day: 04)
            
        }
        
        appDelegate.saveContext()
        
        
    }
    
    fileprivate func buildDate(_ year : Int, month : Int, day : Int) -> Date {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components)!
    }
}

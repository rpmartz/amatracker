import Foundation
import CoreData
import UIKit

class MovementService {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    func fetchMovements() -> [Movement] {
        let request = NSFetchRequest(entityName: "Movement")
        let context = appDelegate.managedObjectContext!
        
        var movementArray: [AnyObject]?
        do {
            movementArray = try context.executeFetchRequest(request)
        } catch let error1 as NSError {
            NSLog("\(error1)")
            movementArray = nil
        }
        
        if movementArray?.count == 0 {
            createMovements()
            do {
                movementArray = try context.executeFetchRequest(request)
            } catch let error1 as NSError {
                NSLog("\(error1)")
                movementArray = nil
            }
        }
        
        return movementArray as! [Movement]
        
    }
    
    private func createMovements() {
        let movementNames = [
            "Back Squat",
            "Front Squat",
            "Overhead Squat",
            "Deadlift",
            "Shoulder Press",
            "Push Press",
            "Jerk",
            "Power Clean",
            "Clean",
            "Clean and Jerk",
            "Power Snatch",
            "Snatch"
        ]
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        for name in movementNames {
            let entityDescription = NSEntityDescription.entityForName("Movement", inManagedObjectContext: managedObjectContext!)
            let movement = Movement(entity: entityDescription!, insertIntoManagedObjectContext:  managedObjectContext!)
            movement.name = name
        }
        
        appDelegate.saveContext()
    }
}

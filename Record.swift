import Foundation
import CoreData

@objc(Record)
class Record: NSManagedObject {

    @NSManaged var date: Date
    @NSManaged var numberOfReps: NSNumber
    @NSManaged var unit: String
    @NSManaged var weight: NSNumber
    @NSManaged var movement: Movement

}

import Foundation

struct MovementRecordViewModel {
    
    let record : Record
    
    var repDescription: String {
        var suffix: String
        if record.numberOfReps == 1 {
            suffix = "Rep"
        }
        else {
            suffix = "Reps"
        }
        
        return "\(record.numberOfReps) \(suffix)"
    }
    
    var recordDate : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        
        return dateFormatter.string(from: record.date as Date)
    }
    
    var weightDescription : String {
        return "\(record.weight) kg"
    }
   
}

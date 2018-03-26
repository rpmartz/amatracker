import Foundation

struct MovementDetailViewModel {
    
    let movement: Movement
    let records: [Record]
    
    init(movement: Movement, records: [Record]) {
        self.movement = movement
        self.records = records
    }
    
    var numberOfRecords : Int {
        return records.count
    }
    
    var movementName : String {
        return movement.name
    }
    
    func recordViewModel(for index: Int) -> MovementRecordViewModel? {
        guard index < records.count else {
            return nil
        }
        
        return MovementRecordViewModel(record: records[index])
    }
    
}

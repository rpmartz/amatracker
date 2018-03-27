import Foundation

class MovementDetailViewModel {
    
    enum SortMode {
        case weight
        case date
    }
    
    let movement: Movement
    var records: [Record]
    
    var sortMode : SortMode = .date {
        didSet {
            self.sortRecords()
        }
    }
    
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
    
    func removeRecordAt(index idx : Int) {
        guard idx < records.count else {
            return
        }
        
        self.records.remove(at: idx)
    }
    
    func sortRecords() {
        switch self.sortMode {
        case .date:
            self.records = records.sorted {
                $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970
            }
        case .weight:
            self.records = records.sorted {
                $0.weight as! Double > $1.weight as! Double
            }
        }
    }
    
    
}

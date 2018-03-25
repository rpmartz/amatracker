import Foundation

struct MovementListViewModel {
    
    var movements: [Movement]
    
    init(movements: [Movement]) {
        self.movements = movements
    }
    
    var numberOfMovements : Int {
        return movements.count
    }
    
    func movementViewModel(for index: Int) -> MovementViewModel? {
        guard index < movements.count else {
            return nil
        }
        
        return MovementViewModel(movement: movements[index])
    }
}


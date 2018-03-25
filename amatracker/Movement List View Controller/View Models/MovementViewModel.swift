import Foundation

struct MovementViewModel {
    
    var movement : Movement
    
    init(movement: Movement) {
        self.movement = movement
    }
    
    var name : String {
        return movement.name
    }
}

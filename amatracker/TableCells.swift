import UIKit

class MovementRecordTableCell: UITableViewCell {
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


class MovementTableCell : UITableViewCell {
    
    @IBOutlet weak var movementNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class PercentageTableCell : UITableViewCell {
    
    @IBOutlet weak var percentageTextLabel: UILabel!
    @IBOutlet weak var weightTextLabel: UILabel!
    
}

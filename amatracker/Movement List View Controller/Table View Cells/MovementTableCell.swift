import UIKit

class MovementTableCell : UITableViewCell {
    
     static let reuseIdentifier = "movementTableCell"
    
    @IBOutlet weak var movementNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(fromViewModel vm: MovementViewModel) {
        self.movementNameLabel.text = vm.name
    }
    
}

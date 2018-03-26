import UIKit

class MovementRecordTableCell: UITableViewCell {
    
    static let reuseIdentifier = "movementRecordCell"

    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(fromViewModel vm: MovementRecordViewModel) {
        self.recordLabel.text = vm.repDescription
        self.dateLabel.text = vm.recordDate
        self.weightLabel.text = vm.weightDescription
    }

}

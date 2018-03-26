import Foundation
import UIKit

extension MovementDetailViewController : UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let record = records[indexPath.row]
        let cell = self.movementRecordTableView.dequeueReusableCell(withIdentifier: "movementRecordCell") as! MovementRecordTableCell
        
        var repDescription: String?
        if record.numberOfReps == 1 {
            repDescription = "Rep"
        }
        else {
            repDescription = "Reps"
        }
        cell.recordLabel.text = "\(record.numberOfReps) \(repDescription!)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        cell.dateLabel.text = dateFormatter.string(from: record.date as Date)
        cell.weightLabel.text = "\(record.weight) kg"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
}

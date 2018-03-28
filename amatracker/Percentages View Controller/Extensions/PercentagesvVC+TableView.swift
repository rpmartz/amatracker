import Foundation
import UIKit

extension PercentagesViewController : UITableViewDelegate {
    
}

extension PercentagesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PercentageTableCell = tableView.dequeueReusableCell(withIdentifier: "percentageCell") as! PercentageTableCell
        
        let currentRowPercentage = percentages[indexPath.row]
        
        if units == MeasurementUnit.kilograms {
            let percentage : Int = Int(currentRowPercentage * oneRepMaxWeightInKgs)
            cell.weightTextLabel.text = "\(percentage) kg"
        }
        else {
            let percentage : Int = Int(currentRowPercentage * oneRepMaxWeightInKgs * POUNDS_TO_KILOS_RATE)
            cell.weightTextLabel.text = "\(percentage) lbs"
        }
        
        cell.percentageTextLabel.text = "\(currentRowPercentage * 100.0)% of 1RM"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentages.count
    }
}

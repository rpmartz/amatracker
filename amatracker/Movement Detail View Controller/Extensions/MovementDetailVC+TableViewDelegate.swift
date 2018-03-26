import Foundation
import UIKit

extension MovementDetailViewController : UITableViewDelegate {
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records[indexPath.row]
        if(record.numberOfReps == 1) {
            performSegue(withIdentifier: SHOW_PERCENTAGES_SEGUE, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let recordToDelete: Record = records[indexPath.row]
            recordService.deleteRecord(recordToDelete)
            
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}

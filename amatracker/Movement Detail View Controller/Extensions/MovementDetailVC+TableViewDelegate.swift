import Foundation
import UIKit

extension MovementDetailViewController : UITableViewDelegate {
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let record = viewModel.recordViewModel(for: indexPath.row)?.record {
            if(record.numberOfReps == 1) {
                performSegue(withIdentifier: SHOW_PERCENTAGES_SEGUE, sender: nil)
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if let recordToDelete: Record = viewModel.recordViewModel(for: indexPath.row)?.record {
                recordService.deleteRecord(recordToDelete)
                viewModel.removeRecordAt(index: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            
        }
    }
}

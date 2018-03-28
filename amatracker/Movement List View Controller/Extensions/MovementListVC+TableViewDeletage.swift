import Foundation
import UIKit

extension MovementListViewController : UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MOVEMENT_DETAIL_SEGUE, sender: self)
    }
}

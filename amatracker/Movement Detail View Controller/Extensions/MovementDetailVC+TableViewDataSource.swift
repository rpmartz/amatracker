import Foundation
import UIKit

extension MovementDetailViewController : UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let recordViewModel = viewModel.recordViewModel(for: index)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovementRecordTableCell.reuseIdentifier) as? MovementRecordTableCell else {
                fatalError("Unexpected Table View Cell")
        }
        
        cell.configure(fromViewModel: recordViewModel!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRecords
    }
}

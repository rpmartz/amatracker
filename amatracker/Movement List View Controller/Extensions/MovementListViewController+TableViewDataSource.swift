import Foundation
import UIKit

extension MovementListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movementViewModel = viewModel.movementViewModel(for: indexPath.row) else {
            fatalError("Could not getfind movement view model")
        }
        let cell: MovementTableCell = tableView.dequeueReusableCell(withIdentifier: MovementTableCell.reuseIdentifier) as! MovementTableCell
        cell.configure(fromViewModel: movementViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovements
    }
    
}

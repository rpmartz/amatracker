import UIKit
import CoreData
import Mixpanel

class MovementListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // MARK: Constants
    let MOVEMENT_DETAIL_SEGUE = "movementDetailSegue"

    @IBOutlet weak var movementTable: UITableView!
    
    var viewModel: MovementListViewModel!
    let movementService = MovementService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black

        let movements = movementService.fetchMovements()
        viewModel = MovementListViewModel(movements: movements)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let mixpanel = Mixpanel.sharedInstance() {
            mixpanel.track("Movement Table Viewed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource functions
    
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
    
    // MARK: UITableViewDelegate required functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MOVEMENT_DETAIL_SEGUE, sender: self)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == MOVEMENT_DETAIL_SEGUE) {
            let destinationViewController : MovementDetailViewController = segue.destination  as! MovementDetailViewController
            
            let indexPathOfSelectedRow : IndexPath = self.movementTable.indexPathForSelectedRow!
            let selectedMovement = viewModel.movementViewModel(for: indexPathOfSelectedRow.row)?.movement
            destinationViewController.movement = selectedMovement
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}


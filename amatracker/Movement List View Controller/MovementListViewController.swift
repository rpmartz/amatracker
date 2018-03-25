import UIKit
import CoreData
import Mixpanel

class MovementListViewController: UIViewController  {
    
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == MOVEMENT_DETAIL_SEGUE) {
            let destinationViewController : MovementDetailViewController = segue.destination  as! MovementDetailViewController
            
            if let indexPathOfSelectedRow : IndexPath = self.movementTable.indexPathForSelectedRow,
                let selectedMovement = viewModel.movementViewModel(for: indexPathOfSelectedRow.row)?.movement{
                
                     destinationViewController.movement = selectedMovement
               
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}


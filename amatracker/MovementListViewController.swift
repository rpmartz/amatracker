import UIKit
import CoreData

class MovementListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // MARK: Constants
    let MOVEMENT_TABLE_CELL = "movementTableCell"
    let MOVEMENT_DETAIL_SEGUE = "movementDetailSegue"

    @IBOutlet weak var movementTable: UITableView!
    
    var movements : [Movement] = []
    let movementService = MovementService()
    let mixpanel = MixpanelService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black

        movements = movementService.fetchMovements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mixpanel.track("Movement Table Viewed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentMovement = movements[indexPath.row]
        let cell: MovementTableCell = tableView.dequeueReusableCell(withIdentifier: MOVEMENT_TABLE_CELL) as! MovementTableCell
        cell.movementNameLabel.text = currentMovement.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
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
            let selectedMovement = movements[indexPathOfSelectedRow.row]
            destinationViewController.movement = selectedMovement
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}


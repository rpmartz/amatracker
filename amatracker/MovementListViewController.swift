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
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black

        movements = movementService.fetchMovements()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mixpanel.track("Movement Table Viewed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentMovement = movements[indexPath.row]
        let cell: MovementTableCell = tableView.dequeueReusableCellWithIdentifier(MOVEMENT_TABLE_CELL) as! MovementTableCell
        cell.movementNameLabel.text = currentMovement.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }
    
    // MARK: UITableViewDelegate required functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(MOVEMENT_DETAIL_SEGUE, sender: self)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == MOVEMENT_DETAIL_SEGUE) {
            let destinationViewController : MovementDetailViewController = segue.destinationViewController  as! MovementDetailViewController
            
            let indexPathOfSelectedRow : NSIndexPath = self.movementTable.indexPathForSelectedRow!
            let selectedMovement = movements[indexPathOfSelectedRow.row]
            destinationViewController.movement = selectedMovement
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}


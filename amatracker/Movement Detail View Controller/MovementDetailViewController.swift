import UIKit
import Mixpanel

class MovementDetailViewController: UIViewController {
    
    let ADD_RECORD_SEGUE = "addRecordSegue"
    let SHOW_PERCENTAGES_SEGUE = "recordsToPercentagesSegue"
    
    @IBOutlet weak var movementRecordTableView: UITableView!
    
    var movement: Movement!
    var records: [Record] = []
    
    let recordService = RecordService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecords()
    }
    
    private func loadRecords() {
        let fetchedRecords = recordService.loadRecordsByMovement(movement)
        records = fetchedRecords!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRecords()
        self.movementRecordTableView.reloadData()
        self.navigationItem.title = movement.name
        
        if let mixpanel = Mixpanel.sharedInstance() {
            // todo fix scene name
            mixpanel.track("Movement Detail Scene Viewed", properties: ["movement": movement.name])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addRecordButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: ADD_RECORD_SEGUE, sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ADD_RECORD_SEGUE {
            let destinationViewController: AddRecordViewController = segue.destination as! AddRecordViewController
            destinationViewController.currentMovement = self.movement
        }
        else if segue.identifier == SHOW_PERCENTAGES_SEGUE {
            let destinationViewController: PercentagesViewController = segue.destination as! PercentagesViewController
            
            let selectedRecord = records[movementRecordTableView.indexPathForSelectedRow!.row]
            let selectedRecordWeight = selectedRecord.weight.floatValue
            destinationViewController.oneRepMaxWeightInKgs = selectedRecordWeight
        }
        
    }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            records.sort(by: sortByDate)
            self.movementRecordTableView.reloadData()
           
        case 1:
            records.sort(by: sortByWeight)
            self.movementRecordTableView.reloadData()
            
        default:
            break
        }
    }
    
    func sortByWeight(_ rec1: Record, rec2: Record) -> Bool {
        return rec1.weight as! Double > rec2.weight as! Double
    }
    
    func sortByDate(_ rec1: Record, rec2: Record) -> Bool {
        return rec1.date.timeIntervalSince1970 > rec2.date.timeIntervalSince1970
    }
    
}

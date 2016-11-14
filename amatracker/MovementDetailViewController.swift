import UIKit

class MovementDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ADD_RECORD_SEGUE = "addRecordSegue"
    let SHOW_PERCENTAGES_SEGUE = "recordsToPercentagesSegue"
    
    @IBOutlet weak var movementRecordTableView: UITableView!
    
    var movement: Movement!
    var records: [Record] = []
    
    let recordService = RecordService()
    let mixpanel = MixpanelService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecords()
    }
    
    func loadRecords() {
        let fetchedRecords = recordService.loadRecordsByMovement(movement)
        records = fetchedRecords!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRecords()
        self.movementRecordTableView.reloadData()
        self.navigationItem.title = movement.name
        
        mixpanel.track("Add Record Scene Viewed", properties: ["movement": movement.name])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let record = records[indexPath.row]
        let cell = self.movementRecordTableView.dequeueReusableCell(withIdentifier: "movementRecordCell") as! MovementRecordTableCell
        
        var repDescription: String?
        if record.numberOfReps == 1 {
            repDescription = "Rep"
        }
        else {
            repDescription = "Reps"
        }
        cell.recordLabel.text = "\(record.numberOfReps) \(repDescription!)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        cell.dateLabel.text = dateFormatter.string(from: record.date as Date)
        cell.weightLabel.text = "\(record.weight) kg"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    // MARK: UITableViewDelegate functions
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // TODO: implement something here
    }
    
    
    @IBAction func addRecordButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: ADD_RECORD_SEGUE, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records[indexPath.row]
        if(record.numberOfReps == 1) {
            performSegue(withIdentifier: SHOW_PERCENTAGES_SEGUE, sender: nil)
        }
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
        return rec1.weight as Double > rec2.weight as Double
    }
    
    func sortByDate(_ rec1: Record, rec2: Record) -> Bool {
        return rec1.date.timeIntervalSince1970 > rec2.date.timeIntervalSince1970
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

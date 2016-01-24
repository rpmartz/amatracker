import Foundation
import UIKit

class PercentagesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let POUNDS_TO_KILOS_RATE : Float = 2.2
    let mixpanel = MixpanelService()
    
    var oneRepMaxWeightInKgs: Float = Float()
    
    @IBOutlet weak var percentagesTableView: UITableView!
    @IBOutlet weak var unitsControl: UISegmentedControl!
    
    let percentages : [Float] = [0.5, 0.55, 0.6, 0.65,
        0.7, 0.75, 0.8, 0.85,
        0.9, 0.95, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mixpanel.track("Percentages Table Viewed")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: PercentageTableCell = tableView.dequeueReusableCellWithIdentifier("percentageCell") as! PercentageTableCell
        
        let currentRowPercentage = percentages[indexPath.row]
        
        if unitsControl.selectedSegmentIndex == 0 {
            let percentage : Int = Int(currentRowPercentage * oneRepMaxWeightInKgs)
            cell.weightTextLabel.text = "\(percentage) kg"
        }
        else {
            let percentage : Int = Int(currentRowPercentage * oneRepMaxWeightInKgs * POUNDS_TO_KILOS_RATE)
            cell.weightTextLabel.text = "\(percentage) lbs"
        }
      
        cell.percentageTextLabel.text = "\(currentRowPercentage * 100.0)% of 1RM"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentages.count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBAction func unitsToggleChanged(sender: UISegmentedControl) {
        self.percentagesTableView.reloadData()
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
        }
    }
}

import Foundation
import UIKit
import Mixpanel

class PercentagesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let POUNDS_TO_KILOS_RATE : Float = 2.2
    
    var oneRepMaxWeightInKgs: Float = Float()
    var units : MeasurementUnit = .kilograms
    
    @IBOutlet weak var percentagesTableView: UITableView!
    @IBOutlet weak var unitsControl: UISegmentedControl!
    
    let percentages : [Float] = [0.5, 0.55, 0.6, 0.65,
        0.7, 0.75, 0.8, 0.85,
        0.9, 0.95, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if units == .pounds {
            self.unitsControl!.selectedSegmentIndex = 1
        }
        
        if let mixpanel = Mixpanel.sharedInstance() {
            mixpanel.track("Percentages Table Viewed")
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PercentageTableCell = tableView.dequeueReusableCell(withIdentifier: "percentageCell") as! PercentageTableCell
        
        let currentRowPercentage = percentages[indexPath.row]
        
        if units == MeasurementUnit.kilograms {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentages.count
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @IBAction func unitsToggleChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.units = .kilograms
        }
        else {
            self.units = .pounds
        }
        self.percentagesTableView.reloadData()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false) { () -> Void in
            
        }
    }
}

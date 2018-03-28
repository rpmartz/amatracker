import Foundation
import UIKit
import Mixpanel

class PercentagesViewController : UIViewController {
    
    let POUNDS_TO_KILOS_RATE : Float = 2.2
    
    var oneRepMaxWeightInKgs: Float = Float()
    var units : MeasurementUnit = .kilograms
    
    @IBOutlet weak var percentagesTableView: UITableView!
    @IBOutlet weak var unitsControl: UISegmentedControl!
    
    let percentages : [Float] = [0.5, 0.55, 0.6, 0.65,
        0.7, 0.75, 0.8, 0.85,
        0.9, 0.95, 1.0]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if units == .pounds {
            self.unitsControl!.selectedSegmentIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let mixpanel = Mixpanel.sharedInstance() {
            mixpanel.track("Percentages Table Viewed")
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Outlets

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

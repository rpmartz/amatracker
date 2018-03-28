import UIKit
import Mixpanel

class CalculatorViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var unitsControl : UISegmentedControl!
    
    @IBAction func showPercentagesButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showPercentagesSegue", sender: self)
        // segue to new controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalculatorViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let mixpanel = Mixpanel.sharedInstance() {
            mixpanel.track("Calculator Scene Viewed")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPercentagesSegue" {
            let destVC : PercentagesViewController = segue.destination as! PercentagesViewController
            
            let weight = NSString(string: weightTextField.text!).floatValue
            
            
            // outlets are nil right now, so set a property and then update it in view percentage's viewDidLoad()
            if self.unitsControl!.selectedSegmentIndex == 0 {
                destVC.units = .kilograms
                destVC.oneRepMaxWeightInKgs = weight
            }
            else {
                destVC.units = .pounds
                
                let divisor : Float = 2.2
                destVC.oneRepMaxWeightInKgs = weight / divisor // convert to lbs
            }
            
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}


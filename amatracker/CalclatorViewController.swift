import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    
    let mixpanel = MixpanelService()
    
    @IBAction func showPercentagesButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("showPercentagesSegue", sender: self)
        // segue to new controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mixpanel.track("Calculator Scene Viewed")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPercentagesSegue" {
            let destVC : PercentagesViewController = segue.destinationViewController as! PercentagesViewController
            
            let weight = NSString(string: weightTextField.text!).floatValue
            destVC.oneRepMaxWeightInKgs = weight
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}


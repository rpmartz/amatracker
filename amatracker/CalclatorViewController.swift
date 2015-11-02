import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func showPercentagesButtonPressed(sender: UIButton) {
        
        
        self.performSegueWithIdentifier("showPercentagesSegue", sender: self)
        // segue to new controller
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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
            destVC.oneRepMaxWeight = weight
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}


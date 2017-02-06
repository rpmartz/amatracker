import Foundation
import Mixpanel

class MixpanelService {
    
    let mixpanel = Mixpanel.sharedInstance(withToken: "80a114d37b7ab76a0d9835b02a47041f")
    
    func track(_ event: String) {
        mixpanel.track(event)
    }
    
    func track(_ event: String, properties: [AnyHashable: Any]) {
        mixpanel.track(event, properties: properties)
    }
}

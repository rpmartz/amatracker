//
//  MixpanelService.swift
//  amatracker
//
//  Created by ryan on 11/26/15.
//  Copyright © 2015 ryan. All rights reserved.
//

import Foundation
import Mixpanel

class MixpanelService {
    
    let mixpanel = Mixpanel.sharedInstanceWithToken("80a114d37b7ab76a0d9835b02a47041f")
    
    func track(event: String) {
        mixpanel.track(event)
    }
    
    func track(event: String, properties: [NSObject : AnyObject]) {
        mixpanel.track(event, properties: properties)
    }
}

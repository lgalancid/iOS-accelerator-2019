//
//  AppSettings.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 03/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

@objc public class AppSettings: NSObject {
    
    @objc public func setNegativeColor(parColor: String) {
        let defaults = UserDefaults.standard
        defaults.set(parColor, forKey: Parameter.negColor)
    }
    
    @objc public func getNegativeColor () -> String {
        let defaults = UserDefaults.standard
        let storedParameter = defaults.object(forKey: Parameter.negColor) as? String
        if storedParameter == nil {
            setNegativeColor(parColor: "Rojo")
            let storedParameter = defaults.object(forKey: Parameter.negColor) as? String
            return storedParameter!
        }
        else { return storedParameter! }
    }
    
}

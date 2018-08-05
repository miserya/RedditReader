//
//  Int+Helper.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

extension Int {
    
    func shortStringValue() -> String {
        var number: Double = Double(self)
        let sign = number < 0.0 ? "-" : ""
        
        number = fabs(number);

        if number < 1000.0 {
            return "\(sign)\(Int(number))";
        }
        
        let units = ["K","M","G","T","P","E"]
        let exp = Int(log10(number)/3.0)
        let roundedNum: Double = round(10.0 * number / pow(1000.0, Double(exp))) / 10.0
        
        return "\(sign)\(roundedNum)\(units[exp-1])"
    }
}

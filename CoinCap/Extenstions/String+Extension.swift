//
//  String+Extension.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//

extension String {
    var compactSum: Self {
        if let value = Double(self) {
            return String(value.formatted(.number.notation(.compactName).locale(Locale(identifier: "en_US"))))
        }
        return "0.00"
    }
    
    var compactDollarSum: Self {
        return "$" + compactSum
    }
}

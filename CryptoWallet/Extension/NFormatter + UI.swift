//
//  Extension.swift
//  CryptoWallet
//
//  Created by mac on 15.02.23.
//

import UIKit

extension UITextField {
    var noOptionalText: String {
        return self.text ?? ""
    }
}

extension UIButton {
    func addButtonRadius(_ radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
}

extension NumberFormatter {
    func getFormattedNumber(format: Double) -> String? {
        let rounding = NumberFormatter()
        rounding.numberStyle = NumberFormatter.Style.decimal
        rounding.maximumFractionDigits = 3
        return rounding.string(from: format as NSNumber)
    }
}


//
//  NSMutableAttributedStringExtension.swift
//  UISDK-iOS
//
//  Created by Banco Santander Brasil on 13/03/19.
//

import UIKit

public extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let normalString = NSMutableAttributedString(string: text, attributes: attrs)
        append(normalString)
        
        return self
    }
    
    @discardableResult func setValueAttributes(_ valueTotal: String, centsSize: Int, valueFont: UIFont, centsFont: UIFont, color: UIColor) -> NSMutableAttributedString {
        
        let valueAttrs: [NSAttributedString.Key: Any] = [.font: valueFont, .foregroundColor: color]
        let value = valueTotal.prefix(valueTotal.count - centsSize)
        let attributedValue = NSMutableAttributedString(string: String(value), attributes: valueAttrs)
        append(attributedValue)
        
        let centsAttrs: [NSAttributedString.Key: Any] = [.font: centsFont, .foregroundColor: color]
        let centsValue = valueTotal.suffix(centsSize)
        let attributedCents = NSMutableAttributedString(string: String(centsValue), attributes: centsAttrs)
        append(attributedCents)
        
        return self
    }
    
    func applyAmountStyle(_ value: String?, centsDigits: Int, symbol: String?, isSymbolAtStart: Bool?, valueFont: UIFont, centsFont: UIFont, valueColor: UIColor) -> NSMutableAttributedString {
        if let valueText = value, let symbol = symbol, let isSymbolAtStart = isSymbolAtStart {
            var value = valueText
            if isSymbolAtStart {
                if value.contains("-") {
                    value.removeFirst()
                }
                self.normal(valueText.contains("-") ? "-\(symbol)" : symbol, font: valueFont, color: valueColor)
            }
            self.setValueAttributes(value, centsSize: centsDigits, valueFont: valueFont, centsFont: centsFont, color: valueColor)
            if !isSymbolAtStart {
                self.normal(symbol, font: centsFont, color: valueColor)
            }
            return self
        }
        return self
    }
    
    
}

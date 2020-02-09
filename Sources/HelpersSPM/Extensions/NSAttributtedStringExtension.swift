//
//  NSAttributtedStringExtension.swift
//  Helpers
//
//  Created by MAC Pilot Globile on 12/07/2019.
//  Copyright © 2019 Sebastián Varela. All rights reserved.
//

import UIKit

public extension NSAttributedString {
	static func amountAttrString(withAmount amount: Double, currency: String, font: UIFont, textColor: UIColor, shrinkPercentage: Float = 0.2, locale: Locale? = nil, negativeColor: UIColor? = nil) -> NSAttributedString? {
		let numberFormatter = NumberFormatter()
		
		let amountNumber = NSNumber(value: amount)
		
		numberFormatter.currencyCode = currency
		numberFormatter.minimumFractionDigits = 2
		numberFormatter.maximumFractionDigits = 2
		numberFormatter.numberStyle = .currency
		
		var hasSymbolAtBegining = false
		
		if let locale = locale {
			numberFormatter.locale = locale
			hasSymbolAtBegining = locale.isCurrencySymbolAtStart()
		} else {
			numberFormatter.locale = Locale.current
			hasSymbolAtBegining = numberFormatter.locale.isCurrencySymbolAtStart()
		}
		
		guard let formattedNumber = numberFormatter.string(from: amountNumber) else {
			print("formatter failed")
			return nil
		}
		
		let smallerFont = font.withSize(CGFloat(ceilf(Float(font.pointSize * 0.8))))
		
		var color = textColor
		
		if let negativeColor = negativeColor,
			amount < 0 {
			color = negativeColor
		}
		
		let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
													NSAttributedString.Key.foregroundColor: color]
		
		var attrsSmaller = attrs
		attrsSmaller[NSAttributedString.Key.font] = smallerFont
		
		let attrText = NSMutableAttributedString(string: formattedNumber, attributes: attrs)
		
		if hasSymbolAtBegining {
			let suffixStr = formattedNumber.suffix(2)
			
			if let range: Range = formattedNumber.range(of: suffixStr) {
				attrText.addAttributes(attrsSmaller, range: NSRange(range, in: formattedNumber))
			}
			
			let prefixStr = formattedNumber.prefix(1)
			
			if let prefixRange: Range = formattedNumber.range(of: prefixStr) {
				attrText.addAttributes(attrsSmaller, range: NSRange(prefixRange, in: formattedNumber))
				attrText.addAttribute(NSAttributedString.Key.baselineOffset, value: smallerFont.pointSize / 6, range: NSRange(prefixRange, in: formattedNumber))
			}
		} else {
			let suffixStr = formattedNumber.suffix(4)
			
			if let range: Range = formattedNumber.range(of: suffixStr) {
				attrText.addAttributes(attrsSmaller, range: NSRange(range, in: formattedNumber))
			}
		}
		
		return attrText
	}
}

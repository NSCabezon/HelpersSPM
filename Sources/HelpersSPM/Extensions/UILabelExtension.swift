import UIKit

public extension UILabel {
	func setAmount(amount: Double, currency: String, font: UIFont, textColor: UIColor, shrinkPercentage: Float = 0.2, locale: Locale? = nil, negativeColor: UIColor? = nil) {
		attributedText = NSAttributedString.amountAttrString(withAmount: amount, currency: currency, font: font, textColor: textColor, shrinkPercentage: shrinkPercentage, locale: locale, negativeColor: negativeColor)
	}
}


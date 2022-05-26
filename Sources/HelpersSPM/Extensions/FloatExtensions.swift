import Foundation

public extension Float {
    var clean1Decimal: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }

	func stringWithSignificantDecimals(_ places: Int = 3) -> String {
		let formatter = NumberFormatter()
		let number = NSNumber(value: self)
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = places
		return String(formatter.string(from: number) ?? "")
	}
}

import Foundation

public extension Double {
    func doubleRounded(toPlaces places: Int = 2) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

	func stringWithSignificantDecimals(_ places: Int = 3) -> String {
		let formatter = NumberFormatter()
		let number = NSNumber(value: self)
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = places
		return String(formatter.string(from: number) ?? "")
	}
}

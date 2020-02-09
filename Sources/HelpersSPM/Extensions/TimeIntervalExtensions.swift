import Foundation

public extension TimeInterval {
    var milliseconds: Int {
        let whole = floor(self)
        let decimal = self - whole
        
        let numberString = String(decimal)
        let parts = numberString.components(separatedBy: ".")
        var final = parts[1]
        var iterate = parts[1].count
        while iterate < 3 {
            final += "0"
            iterate += 1
        }
        let index = final.index(final.startIndex, offsetBy: 2)
        final = "\(Int(whole))" + final[...index]
        return Int(final)!
    }
}

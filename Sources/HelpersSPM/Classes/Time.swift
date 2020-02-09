import Foundation

public struct Time: Comparable, CustomStringConvertible, Strideable {
    public let hours: Int
    public let minutes: Int
    public let seconds: Int
    
    public init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    public init?(timeString: String) {
        let parts = timeString.components(separatedBy: ":")
        
        guard parts.count == 2 || parts.count == 3 else {
            return nil
        }
        guard let hour = Int(parts[0]), let minute = Int(parts[1]) else {
            return nil
        }
        
        self.hours = hour
        self.minutes = minute
        
        if parts.count == 3 {
            guard let second = Int(parts[2]) else {
                return nil
            }
            self.seconds = second
        } else {
            self.seconds = 0
        }
    }
    
    func timeByAdding(seconds: Int) -> Time {
        var newSeconds = self.seconds + seconds
        var newMinutes = self.minutes
        var newHours = self.hours
        if newSeconds > 59 {
            newMinutes += (newSeconds / 60)
            newSeconds -= (newSeconds / 60) * 60
        }
        if newMinutes > 59 {
            newHours += (newMinutes / 60)
            newMinutes -= (newMinutes / 60) * 60
        }
        return Time(hours: newHours, minutes: newMinutes, seconds: newSeconds)
    }
    
    var totalSeconds: Int {
        return hours * 60 * 60 + minutes * 60 + seconds
    }
    
    func toFormattedTimeString(showSeconds: Bool = false) -> String {
        if showSeconds {
            return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
        return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes))h."
    }
    
    // MARK: - CustomStringConvertible
    public var description: String {
        return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    // MARK: - Strideable
    public func distance(to other: Time) -> Time.Stride {
        return totalSeconds + other.totalSeconds
    }
    
    public func advanced(by nSec: Time.Stride) -> Time {
        return timeByAdding(seconds: nSec)
    }
    
    public typealias Stride = Int
}

public func == (lhs: Time, rhs: Time) -> Bool {
    return lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.seconds == rhs.seconds
}

public func < (lhs: Time, rhs: Time) -> Bool {
    if lhs.hours == rhs.hours && lhs.minutes == rhs.minutes {
        return lhs.seconds < rhs.seconds
    }
    if lhs.hours == rhs.hours {
        return lhs.minutes < rhs.minutes
    }
    return lhs.hours < rhs.hours
}

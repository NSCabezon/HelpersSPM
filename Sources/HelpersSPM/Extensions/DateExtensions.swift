import Foundation

public extension Date {
    var firstDayOfCurrentMonth: Date {
        return (Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)))!
    }
    
    var isFirstDayOfCurrentMonth: Bool {
        return self == firstDayOfCurrentMonth
    }
    
    var firstHourOfCurrentDate: Date {
        return (Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)))!
    }
    
    var lastDayOfCurrentMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfCurrentMonth)!
    }

    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }

    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    var minute: Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
    
    func toFormattedSpanishDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let converted = dateFormatter.string(from: self)
        return converted
    }
    
    func toFormattedSpanishFullDateString(useHourSuffix: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        if useHourSuffix {
            dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm'h.'"
        } else {
            dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
        }
        let converted = dateFormatter.string(from: self)
        return converted
    }
    
    func toFormattedSpanishFullDateString(withEndDate end: Date, useHourSuffix: Bool = true) -> String {
        let datef = DateFormatter()
        datef.dateFormat = "dd/MM/yyyy"
        let timef = DateFormatter()
        if useHourSuffix {
            timef.dateFormat = "HH:mm'h.'"
        } else {
            timef.dateFormat = "HH:mm"
        }
        
        return "\(datef.string(from: self)) - \(timef.string(from: self)) a \(timef.string(from: end))"
    }
    
    func toFormattedSpanishMonthName() -> String {
        let datef = DateFormatter()
        datef.dateFormat = "M MMMM"
        
        return "\(datef.string(from: self))"
    }

    func toFormattedJsonDateString(useUtc: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        if useUtc {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        let converted = dateFormatter.string(from: self)
        return converted
    }

    func toFormattedPOSIXDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }
    
    func dateByAdding(years: Int) -> Date {
        let components = DateComponents(year: years)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func dateByAdding(days: Int) -> Date {
        let components = DateComponents(day: days)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func dateByAdding(months: Int) -> Date {
        let components = DateComponents(month: months)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func dateByAdding(hours: Int) -> Date {
        let components = DateComponents(minute: minute)
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func dateByAdding(minutes: Int) -> Date {
        let components = DateComponents(minute: minute)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func totalDays(from date: Date) -> Int {
        if self < date {
            return 0
        }
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func days(from date: Date) -> [Date] {
        var days = [Date]()
        for iterator in 0...self.totalDays(from: date) {
            days.append(date.dateByAdding(days: iterator))
        }
        return days
    }
    
    func totalMonths(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date.firstDayOfCurrentMonth, to: self.firstDayOfCurrentMonth).month ?? 0
    }
    
    func totalAbsoluteMonths(from date: Date) -> Int {
        return self.totalMonths(from: date) + 1
    }
    
    var localTime: Time {
        let timef = DateFormatter()
        timef.dateFormat = "HH:mm:ss"
        
        let timeString = timef.string(from: self)
        let components = timeString.components(separatedBy: ":")
        
        return Time(hours: Int(components[0])!, minutes: Int(components[1])!, seconds: Int(components[2])!)
    }
}

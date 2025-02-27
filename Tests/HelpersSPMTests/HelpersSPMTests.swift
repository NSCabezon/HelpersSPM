import XCTest

@testable import HelpersSPM

final class HelpersSPMTests: XCTestCase {
    @MainActor func testMediumFormatter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let expectedResult = "Jan 1, 1970 at 12:00:00 AM"
        let df = DateFormatter.medium
        let date = Date(timeIntervalSince1970: 0)
        df.timeZone = TimeZone(abbreviation: "GMT")
        let result = df.string(from: date)
        XCTAssertEqual(expectedResult, result)
    }
    
    @MainActor func testISO8601Formatter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let expectedResult = "1970-01-01T00:00:00.000Z"
        let df = DateFormatter.iso8601
        let date = Date(timeIntervalSince1970: 0)
        let result = df.string(from: date)
        XCTAssertEqual(expectedResult, result)
    }

    @MainActor static var allTests = [
        ("FormatterTests", testMediumFormatter),
        ("FormatterTests", testISO8601Formatter),
    ]
}

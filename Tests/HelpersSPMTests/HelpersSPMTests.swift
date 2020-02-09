import XCTest
@testable import HelpersSPM

final class HelpersSPMTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
		XCTAssertEqual("Hi", "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

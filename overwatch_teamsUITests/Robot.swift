import XCTest

class Robot {
         var app = XCUIApplication()
 
         func tap(_ element: XCUIElement, timeout: TimeInterval = 5) {
            let predicate = NSPredicate(format: "isHittable == true")
            let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
            guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
                XCTAssert(false, "Element \(element.label) not hittable")
                return
            }
         }
 
    func assertExists(_ elements: XCUIElement, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: elements)
        
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTAssert(false, "Element does not exist")
            return
        }
    }
}

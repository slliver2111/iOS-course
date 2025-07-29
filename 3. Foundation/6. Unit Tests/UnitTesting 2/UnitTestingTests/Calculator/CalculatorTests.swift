//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let result1 = try calculator.divide(20, 10)
        XCTAssertEqual(2, result1)
        
        let result2 = try calculator.divide(10.0, 20.0)
        XCTAssertEqual(0.5, result2)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(10.0, 0)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, Calculator.CalculatorError.divisionByZero)
        }
    
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        XCTAssertTrue(calculator.isGreaterThanTen(20))
        XCTAssertFalse(calculator.isGreaterThanTen(10))
        XCTAssertFalse(calculator.isGreaterThanTen(-20))
    }

    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        XCTAssertNotNil(calculator.safeSquareRoot(20.0))
        XCTAssertEqual(calculator.safeSquareRoot(16.0), 4.0)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        XCTAssertNil(calculator.safeSquareRoot(-16))
    }
}

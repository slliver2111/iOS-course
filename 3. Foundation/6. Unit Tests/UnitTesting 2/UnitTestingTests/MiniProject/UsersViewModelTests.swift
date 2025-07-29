//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        sut.fetchUsers {}
        XCTAssertEqual(mockService.fetchUsersCallsCount, 1)
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        sut.fetchUsers {}
        let requiredUrl = "https://jsonplaceholder.typicode.com/users"
        XCTAssertEqual(requiredUrl, mockService.passedURLString)
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        let expectedUsers =  [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        mockService.fetchUsersResult = .success(expectedUsers)
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Wait for fetchUser endning")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertNil(sut.errorMessage)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.invalidUrl)
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Wait for fetchUser endning")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Wait for fetchUser endning")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Wait for fetchUser endning")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        let expectedUsers =  [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        mockService.fetchUsersResult = .success(expectedUsers)
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Wait for fetchUser endning")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertNil(sut.errorMessage)
        
        sut.clearUsers()
        
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertNil(sut.errorMessage)        
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}

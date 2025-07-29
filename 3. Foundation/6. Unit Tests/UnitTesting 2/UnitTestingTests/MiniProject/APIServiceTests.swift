//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var validURL: String = "https://jsonplaceholder.typicode.com/users"
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let wrongURL = ""
        let expectation = self.expectation(description: "Wait for fetchUsers")
        sut.fetchUsers(urlString: wrongURL, completion: {result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(error):
                XCTAssertEqual(error, .invalidUrl)
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let expectation = self.expectation(description: "Wait for fetchUsers")
        
        sut.fetchUsers(urlString: validURL, completion: { result in
            switch result {
            case let .success(expectedUsers):
                XCTAssertEqual(expectedUsers.count, 2)
                XCTAssertEqual(expectedUsers[0].name, "John Doe")
                XCTAssertEqual(expectedUsers[1].email, "johndoe@gmail.com")
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let response = "Some broken data !@#".data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let expectation = self.expectation(description: "Wait for fetchUsers")
        
        sut.fetchUsers(urlString: validURL, completion: { result in
            switch result {
            case .success:
                XCTFail("Exptected failure but got success")
            case let .failure(error):
                XCTAssertEqual(error, .parsingError)
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0)
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        mockURLSession.mockError = APIError.unexpected
        let sut = makeSut()
        let expectation = self.expectation(description: "Wait for fetchUsers")
        
        sut.fetchUsers(urlString: validURL, completion: {result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(error):
                XCTAssertEqual(error, .unexpected)
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: Fetch Users Async
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        let wrongURL = ""
        let result = await sut.fetchUsersAsync(urlString: wrongURL)
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case let .failure(error):
            XCTAssertEqual(error, .invalidUrl)
        }
        
    }
    
    // add other tests for fetchUsersAsync
    
    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsersAsync_whenInvalidSuccessfulResponse_completesWithFailure() async {
        let response = "Some broken data !@#".data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: validURL)
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case let .failure(error):
            XCTAssertEqual(error, .parsingError)
        }
        
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsersAsync_whenError_completesWithFailure() async {
        mockURLSession.mockError = APIError.unexpected
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: validURL)
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case let .failure(error):
            XCTAssertEqual(error, .unexpected)
        }
        
    }
    
    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}

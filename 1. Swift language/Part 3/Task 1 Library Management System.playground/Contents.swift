//What should be done
//*
//Steps:
//
//Define a protocol Borrowablewith properties borrowDate, returnDate, and a method checkIn().
//borrowDate: Optional Date for when the item was borrowed.
//returnDate: Optional Date for when the item should be returned.
//isBorrowed: Boolean indicating if the item is currently borrowed.
//checkIn(): handles item return processes, resetting dates and status.
//2. Provide a default implementation of the Borrowable:
//
//isOverdue() -> Bool: Method to check if the item is overdue based on returnDate.
//checkIn(): Method to clear borrowDate, returnDate, and set isBorrowed to false, allowing the item to be available for borrowing again.
//3. Create Classes:
//
//Item Class: A base class Item with properties: id: Unique identifier for the item, title: The title of the item and author: Author of the item.
//Book Subclass: A subclass of Item, Book, conforming to the Borrowable protocol and inheriting properties from Item.
//4. Define an enumeration LibraryError with specific cases to handle various errors such as:
//
//itemNotFound: Triggered when an attempted borrow action is requested on an item ID that does not exist.
//itemNotBorrowable: Triggered if an item does not conform to the Borrowable protocol.
//alreadyBorrowed: Triggered if an item is already borrowed.
//5. Create a Library class that manages collections of items. Include:
//
//A dictionary to store items with their ID as the key.
//addBook(_ book: Book): Method to add books to the library’s collection.
//borrowItem(by id: String) -> Item: Method that attempts to let a user borrow an item using its ID: Use optional chaining to handle potential nil values. Ensure accurate error handling using throws to manage errors such as itemNotFound, itemNotBorrowable, and alreadyBorrowed.
//6. Implement optional chaining in the borrowItem(by:)method to handle cases where an item might not be found or might not conform to Borrowable, thus avoiding runtime errors and smoothly handling exceptional cases.

import Foundation

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    var defaultBorrowingDays: Double { get }
    mutating func checkIn()
}

extension Borrowable{
    func isOverDue() -> Bool {
        guard let newReturnDate = self.returnDate, self.isBorrowed else {
            return false
        }
        return Date() > newReturnDate
    }
    
    mutating func checkIn() {
        self.borrowDate = nil
        self.returnDate = nil
        self.isBorrowed = false
        print("Success: Checkin ok")
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    var isBorrowed: Bool
    var returnDate: Date?
    var borrowDate: Date?
    var defaultBorrowingDays: Double = 20
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
        self.returnDate = nil
        self.borrowDate = nil
        self.isBorrowed = false
    }
}

class Book: Item, Borrowable {}

class Magazine: Item {}


enum LibraryError: Error{
    case itemNotFound, itemNotBorrowable, alreadyBorrowed
}

class Library{
    var items: [String:Item]
    
    init() {
        self.items = [:]
    }
    
    func addBook(_ book: Book) {
        self.items[book.id] = book
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard var item = self.items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard item.isBorrowed != true else {
            throw LibraryError.alreadyBorrowed
        }
        
        guard item is Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        item.borrowDate = Date()
        item.returnDate = Date().addingTimeInterval(86400 * item.defaultBorrowingDays)
        item.isBorrowed = true
        print("Success: Checkout ok")

        return item
    }
    
    func borrowItemPrintError(by id: String) -> Item?{ //method created for tests purposes
        do{
            let userItem = try borrowItem(by: id)
            print("Success: Borrow \(userItem.title) ok")
            return userItem
        } catch LibraryError.itemNotFound {
            print("Error: Book is not available")
        } catch LibraryError.alreadyBorrowed {
            print("Error: Book is already borrowed")
        } catch LibraryError.itemNotBorrowable {
            print("Error: Book is not borrowable")
        } catch {
            print("Error: Unknown error")
        }
        return nil
    }
}

let myLibrary = Library()
let myBook1 = Book(id: "00", title: "LOTR", author: "Tolkien")
let myBook2 = Book(id: "01", title: "Harry Potter", author: "JK Rowling")
let myBook3 = Book(id: "02", title: "the Winnie Poth", author: "I dont know")

myLibrary.addBook(myBook1)
myLibrary.addBook(myBook2)
myLibrary.addBook(myBook3)

var userItem1: Item?
var userItem2: Item?

// Expected: Success
userItem1 = myLibrary.borrowItemPrintError(by: "00")

// Expected: Book is already borrowed
userItem2 = myLibrary.borrowItemPrintError(by: "00")

// Return to library a book 00
if var borrowableItem = userItem1 as? Borrowable {
    borrowableItem.checkIn()
} else {
    print("Error: Failed to cast '\(userItem1?.title ?? "ID 00")'")
}

//Expected: Success
myLibrary.borrowItemPrintError(by: "00")

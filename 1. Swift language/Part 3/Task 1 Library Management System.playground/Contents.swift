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
    func overDue() -> Bool
    func checkIn()
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var returnDate: Date?
    var borrowDate: Date?
    var isBorrowed: Bool
    static let numberOfDaysToBorrow: Double = 20
    
    override init(id: String, title: String, author: String) {
        self.returnDate = nil
        self.borrowDate = nil
        self.isBorrowed = false
        super.init(id: id, title: title, author: author)
    }
    
    func overDue() -> Bool { //TODO
        return Date.now > self.returnDate ?? Date.now
    }
    
    func checkIn() {
        self.borrowDate = nil
        self.returnDate = nil
        self.isBorrowed = false
    }
    
    func checkOut() {
        self.borrowDate = Date.now
        self.returnDate = Date.now.addingTimeInterval(86400 * Book.numberOfDaysToBorrow)
        self.isBorrowed = true
    }
}


enum LibraryError: Error{
    case itemNotFound, itemNotBorrowable, alreadyBorrowed
}

class Library{
    var books: [String:Book]
    
    init() {
        self.books = [:]
    }
    
    func addBook(_ book: Book) {
        self.books[book.id] = book
    }
    
    func borrowItem(by id: String) throws -> Item? {
        guard let book = self.books[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard book.isBorrowed != true else {
            throw LibraryError.alreadyBorrowed
        }
        
        guard book is Borrowable else { //TODO
            throw LibraryError.itemNotBorrowable
        }
        
        book.checkOut()
        
        return self.books[id]
    }
    
}

let myLibrary = Library()
let myBook1 = Book(id: "00", title: "LOTR", author: "Tolkien")
let myBook2 = Book(id: "01", title: "Harry Potter", author: "JK Rowling")
let myBook3 = Book(id: "02", title: "the Winnie Poth", author: "I dont know")

myLibrary.addBook(myBook1)
myLibrary.addBook(myBook2)
myLibrary.addBook(myBook3)

let userItem1: Item?
let userItem2: Item?
let userItem3: Item?

// Expected: Success
do{
    userItem1 = try myLibrary.borrowItem(by: "00")
    print("Success")
    
    if let userBook1 = userItem1 as? Book {
       print("Book is overdue \(userBook1.overDue())")
    } else {
        print("Failed to cast to Dog.")
    }
} catch LibraryError.itemNotFound {
    print("Book is not available")
} catch LibraryError.alreadyBorrowed {
    print("Book is already borrowed")
} catch LibraryError.itemNotBorrowable {
    print("Book is \(LibraryError.itemNotBorrowable.hashValue)")
}


// Expected: Book is already borrowed
do{
    userItem2 = try myLibrary.borrowItem(by: "00")
} catch LibraryError.itemNotFound {
    print("Book is not available")
} catch LibraryError.alreadyBorrowed {
    print("Book is already borrowed")
} catch LibraryError.itemNotBorrowable {
    print("Book is \(LibraryError.itemNotBorrowable.hashValue)")
}

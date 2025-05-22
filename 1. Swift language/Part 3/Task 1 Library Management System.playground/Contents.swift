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


protocol Borrowable {
    var borrowDate: String { get set }
    var returnDate: String { get set }
    var isBorrowed: Bool { get set }
    mutating func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        //TODO Method to check if the item is overdue based on returnDate.
        return false
    }
    
    mutating func checkIn() {
        borrowDate = ""
        returnDate = ""
        isBorrowed = false
    }
}

class Item {
    let id: Int
    let title: String
    let author: String
    
    init(id: Int, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
    
}

class Book: Item, Borrowable {
    var returnDate: String
    var borrowDate: String
    var isBorrowed: Bool
    
    init(id: Int, title: String, author: String, returnDate: String, isBorrowed: Bool, borrowDate: String) {
        self.returnDate = returnDate
        self.isBorrowed = isBorrowed
        self.borrowDate = borrowDate
        super.init(id: id, title: title, author: author)
    }
}


enum LibraryError{
    case itemNotFound, itemNotBorrowable, alreadyBorrowed
}

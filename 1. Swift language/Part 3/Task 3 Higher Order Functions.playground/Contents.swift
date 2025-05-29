//What should be done
//Steps:
//1. Assume you have an array of dictionaries. Each dictionary contains details about books (title, author, year, price, and genre). Use this:
//let books = [
//["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
//["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
//["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
//["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
//["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
//]
//2. Define new global variable of type Array<Double> named`discountedPrices` that will include just the prices of the above books with a 10% discount applied. Use `map`/`compactMap` to solve this.
//3. Define new global variable of type Array<String> named `booksPostedAfter2000` that will include book titles of the books published after the year 2000. Use `filter` to solve this.
//4. Define new global variable of type Set<String> named `allGenres` that will include all the genres available in the books. Use `flatMap` to solve this.
//5. Define new global variable of type Int named `totalCost` to find out how much it would cost to purchase one instance of each book. Use `reduce`.

let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]]

let pricesDouble = books.compactMap{ book -> Double? in
    
    switch book["price"]{
    case let intValue as Int:
        return Double(intValue)
    case let doubleValue as Double:
        return doubleValue
    case let stringValue as String:
        if let newDouble = Double(stringValue) {
            return newDouble
        } else {
            return nil
        }
    default:
        return nil
    }
}
let discountedPrices: Array<Double> = pricesDouble.map{ $0 * 0.9 }

let booksPostedAfter2000: Array<String> = books.filter{ book -> Bool in
    
    switch book["year"]{
    case let intValue as Int:
        return intValue > 2000
    case let doubleValue as Double:
        return Int(doubleValue) > 2000
    case let stringValue as String:
        if let newInt = Int(stringValue) {
            return newInt > 2000
        } else {
            return false
        }
    default:
        return false
    }
    
}.compactMap{ $0["title"] as? String}

let arrayOfGenres = books.flatMap{book -> [String] in return book["genre"] as? [String] ?? []}
let allGenres: Set<String> = Set(arrayOfGenres)
let totalCost: Int = Int(pricesDouble.reduce(0.0, +))


//Outputs
print("List of discounted -10% prices \(discountedPrices)")
print("List of books posted after 2000 \(booksPostedAfter2000)")
print("Set of all genres: \(allGenres)")
print("Total cost is: \(totalCost)")

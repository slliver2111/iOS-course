///1. Assume you have an array of dictionaries. Each dictionary contains details about books (title, author, year, price, and genre). Use this:
///let books = [
///["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
///["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
///["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
///["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
///["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
///]

let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]]

///2. Define new global variable of type Array<Double> named`discountedPrices` that will include just the prices of the above books with a 10% discount applied. Use `map`/`compactMap` to solve this.
///1. version - it assumes only Int in prices
//var discountedPrices_Ints: Array<Double> = books.map{ val in return Double(val.compactMap{ $0 == "price" ? $1 : nil }[0] as! Int)*0.9 }
///2. version - safe
var prices = books.compactMap{ $0["price"] }
var discountedPrices: Array<Double> = prices.compactMap{ price -> Double? in
    
    switch price{
        case let intValue as Int:
            return Double(intValue) * 0.9
        case let doubleValue as Double:
            return doubleValue * 0.9
        case let stringValue as String:
            if let newDouble = Double(stringValue) {
                return newDouble * 0.9
            } else {
                return nil
            }
        default:
            return nil
        }
}

///3. Define new global variable of type Array<String> named `booksPostedAfter2000` that will include book titles of the books published after the year 2000. Use `filter` to solve this.

let booksPostedAfter2000: Array<String> = books.filter{ $0["year"] as? Int ?? 0 > 2000 }.compactMap{ $0["title"] as? String }

///4. Define new global variable of type Set<String> named `allGenres` that will include all the genres available in the books. Use `flatMap` to solve this.

let arrayOfGenres = books.flatMap{book -> [String] in return book["genre"] as? [String] ?? []}
let allGenres: Set<String> = Set(arrayOfGenres)

///5. Define new global variable of type Int named `totalCost` to find out how much it would cost to purchase one instance of each book. Use `reduce`.

// We assume prices are always Int. If not another implemention required
var totalCost: Int = books.reduce(0){ result, book in return result + (book["price"] as? Int ?? 0)}

//Outputs
print("List of discounted -10% prices \(discountedPrices)")
print("List of books posted after 2000 \(booksPostedAfter2000)")
print("Set of all genres: \(allGenres)")
print("Total cost is: \(totalCost)")

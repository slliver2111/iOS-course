//class NamedShape {
//    var numberOfSides = 0
//    var name: String
//    
//    init(_ name: String){
//        self.name = name
//    }
//    
//    func simpleDescription() -> String {
//        return "A shape with \(numberOfSides) sides."
//    }
//    
//    func changeSides(_ NewValue: Int) {
//            numberOfSides = NewValue
//    }
//}
//
//class Square: NamedShape {
//    var sideLength: Double
//
//
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name)
//        numberOfSides = 4
//    }
//
//
//    func area() -> Double {
//        return sideLength * sideLength
//    }
//
//
//    override func simpleDescription() -> String {
//        return "A square with sides of length \(sideLength)."
//    }
//}
//
//class Circle: NamedShape {
//    var radiusLength: Double
//
//
//    init(radiusLength: Double, name: String) {
//        self.radiusLength = radiusLength
//        super.init(name)
//        numberOfSides = 4
//    }
//
//
//    func area() -> Double {
//        return radiusLength * radiusLength * 3.14
//    }
//
//
//    override func simpleDescription() -> String {
//        return "A cricle with radius of lengrth \(radiusLength)."
//    }
//}
//
//
//var shape = NamedShape("kotek")
//shape.numberOfSides = 7
//var shapeDescription = shape.simpleDescription()
//
//let mySquare = Square(sideLength: 5.2, name: "my test square")
//mySquare.area()
//mySquare.simpleDescription()
//
//let myCircle = Circle(radiusLength: 5.2, name: "my test square")
//mySquare.area()
//mySquare.simpleDescription()
//
//class EquilateralTriangle: NamedShape {
//    var sideLength: Double = 0.0
//
//
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name)
//        super.numberOfSides = 3
//    }
//
//
//    var perimeter: Double {
//        get {
//             return 3.0 * sideLength
//        }
//        set(newMyValue) {
//            sideLength = (newMyValue) / 3.0
//        }
//    }
//
//
//    override func simpleDescription() -> String {
//        return "An equilateral triangle with sides of length \(sideLength)."
//    }
//}
//var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
//print(triangle.perimeter)
//// Prints "9.3"
//triangle.perimeter = 9.9
//print(triangle.sideLength)
//// Prints "3.3000000000000003"
//
//
//class TriangleAndSquare {
//    var triangle: EquilateralTriangle {
//        willSet {
//            square.sideLength = newValue.sideLength
//        }
//    }
//    var square: Square {
//        willSet {
//            triangle.sideLength = newValue.sideLength
//        }
//    }
//    init(size: Double, name: String) {
//        square = Square(sideLength: size, name: name)
//        triangle = EquilateralTriangle(sideLength: size, name: name)
//    }
//}
//var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
//print(triangleAndSquare.square.sideLength)
//// Prints "10.0"
//print(triangleAndSquare.triangle.sideLength)
//// Prints "10.0"
//triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
//print(triangleAndSquare.triangle.sideLength)
//// Prints "50.0"


enum Rank: Int{
    
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king


    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace.simpleDescription()



func CompareRanks(_ rank1: Rank, _ rank2: Rank) -> Int {
    return abs(rank1.rawValue - rank2.rawValue)
}


if let convertedRank = Rank(rawValue: 11) {
    let threeDescription = convertedRank.simpleDescription()
}


enum Suit {
    case spades, hearts, diamonds, clubs


    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades:
            return "black"
        case .clubs:
            return "black"
        case .hearts:
            return "red"
        case .diamonds:
            return "red"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

let myColor = hearts.color()

enum ServerResponse {
    case result(String, String)
    case failure(String)
    case test(String)
}


let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
let test = ServerResponse.test("Spinach")


switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
case let .test(output):
    print("Testing \(output)")
}
// Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."


struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

func Deck() -> [Card] {
    var deck: [Card] = []
    
    let ranks = [Rank.ace, Rank.two]
    let suits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades]

    
    for rank in ranks {
        for suit in suits {
            deck.append(Card(rank: rank, suit: suit))
        }
    }
    
    return deck
}

Deck()

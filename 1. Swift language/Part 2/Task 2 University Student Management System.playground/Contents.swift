//1. Create a Person base class with the following:
//• Properties: name (String), age (Int)
//• A designated initializer
//• A failable initializer (fails if age is less than 16)
//2. Create a Student subclass that inherits from Person with additional properties:
//• studentID (String)
//• major (String)
//• A required initializer
//• A convenience initializer
//3. Create a Professor subclass with additional properties:
//• faculty (String)
//• A custom initializer calling the superclass
//4. Create a University struct with properties:
//• name (String), location (String)
//• A memberwise initializer (default in Swift for structs)

class Person {
    let name: String
    let age: Int
    
    // A designated initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // A failable initializer (fails if age is less than 16)
    init?(name: String, ageCheck age: Int) {
        guard age >= 16 else {
            print("Person init failed. Person need to be >= 16")
            return nil
        }
        self.name = name
        self.age = age
    }
}


class Student: Person {
    let studentID: String
    var major: String = ""
    
    // A required initializer
    required init?(name: String, age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, ageCheck: age)
    }
    
    // A convenience initializer
    convenience init?(name: String, age: Int, studentID: String, major: String) {
        self.init(name: name, age: age, studentID: studentID)
        self.major = major
    }
}


class Professor: Person {
    let faculty: String
    
    // A custom initializer calling the superclass
    init?(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, ageCheck: age)
    }
    
}

// A memberwise initializer (default in Swift for structs)
struct University{
    var name: String
    var location: String
}

var artur = Person(name: "Artur", age: 10)
var ola = Person(name: "Ola", age: 22)

var pawel = Student(name: "Pawel", age: 22, studentID: "2213")
var prz = University(name: "Prz", location: "Rzeszow")


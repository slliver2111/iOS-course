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
    
    // A required initializers
    required init(name: String, age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, age: age)
    }
    
    // Cover ageCheck feature
    init?(name: String, ageCheck age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, ageCheck: age)
    }
    
    // A convenience initializer
    convenience init(name: String, age: Int, studentID: String, major: String) {
        self.init(name: name, age: age, studentID: studentID)
        self.major = major
    }
    
    // Cover ageCheck feature
    convenience init?(name: String, ageCheck age: Int, studentID: String, major: String) {
        self.init(name: name, ageCheck: age, studentID: studentID)
        self.major = major
    }
}


class Professor: Person {
    let faculty: String
    
    // A custom initializer calling the superclass
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
    
    // Cover ageCheck feature
    init?(name: String, ageCheck age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, ageCheck: age)
    }
}

//class MedicineStudent: Student {
//    required init(name: String, age: Int, studentID: String) {
//        super.init(name: name, age: age, studentID: studentID)
//    }
//}

// A memberwise initializer (default in Swift for structs)
struct University{
    var name: String
    var location: String
}

let artur = Person(name: "Artur", age: 10)
let ola = Person(name: "Ola", age: 22)
let tomek = Person(name: "Tomek", ageCheck: 19)
let lukas = Person(name: "Lukas", ageCheck: 10) // Expected nil
let maciek = Student(name: "Maciek", age: 20, studentID: "01")
let marta = Student(name: "Marta", age: 20, studentID: "02", major: "IT")
let marek = Student(name: "Marek", ageCheck: 20, studentID: "00")
let romek = Student(name: "Romek", ageCheck: 10, studentID: "03") // Expected nil
let weronika = Student(name: "Weronika", ageCheck: 10, studentID: "04", major: "Medicine") // Expected nil

let pawel = Professor(name: "Pawel", age: 22, faculty: "History")
let prz = University(name: "Prz", location: "Rzeszow")


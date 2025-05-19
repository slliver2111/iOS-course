//What should be done
//*
//Steps to Implement:
//
//1. Modify Person class:
//
//• Add a computed property (isAdult: Bool) which check age >= 18
//
//• Add a static property (minAgeForEnrollment = 16)
//
//• Add a lazy property (profileDescription) which return "\(name) is \(age) years old."
//
//2. Modify Student subclass:
//
//• Add a static counter to track the number of students - studentCount
//
//• Add a weak reference to an optional Professor (advisor)
//
//• Add a computed property to format studentID - formattedID, which return "ID: " and studentID in uppercased
//
//3. Modify Professor subclass:
//
//• Add a static counter for professors - professorCount
//
//• Add a computed property for fullTitle
//
//4. Modify University struct:
//
//• Add a computed property (description)

actor StudentCounter {
    var counter = 0
    
    func increment() {
        counter += 1
    }
    
    func getValue() -> Int {
        return counter
    }
}

actor ProfessorCounter {
    var counter = 0
    
    func increment() {
        counter += 1
    }
    
    func getValue() -> Int {
        return counter
    }
}

// Global instance of counter actor
let studentCounter = StudentCounter()
let professorCounter = ProfessorCounter()

class Person {
    let name: String
    let age: Int
    var isAdult: Bool {
        return age >= 18
    }
    static let minAgeForEnrollment = 16
    lazy var profileDescription: String = {
        return "\(name) is \(age) years old."
    }()
    
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
    weak var advisor: Professor?
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }
    
    // Add a static counter to track the number of students - studentCount
    static func studentCount() async -> Int {
        return await studentCounter.getValue()
    }
    
    // A required initializer
    required init?(name: String, age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, ageCheck: age)
        Task {
            await studentCounter.increment()
        }
    }
    
    // A convenience initializer
    convenience init?(name: String, age: Int, studentID: String, major: String) {
        self.init(name: name, age: age, studentID: studentID)
        self.major = major
    }
}


class Professor: Person {
    let faculty: String
    var fullTitle: String {
        return "Prof. of \(faculty) \(name)"
    }
    
    // Add a static counter to track the number of professors - professorCount
    static func professorCount() async -> Int {
        return await professorCounter.getValue()
    }
    
    // A custom initializer calling the superclass
    init?(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, ageCheck: age)
        Task {
            await professorCounter.increment()
        }
    }
    
}

// A memberwise initializer (default in Swift for structs)
struct University{
    var name: String
    var location: String
    
    var description: String {
        return "The \(name) located in \(location)"
    }
}

var artur = Person(name: "Artur", age: 10)
var ola = Person(name: "Ola", age: 22)

var pawel = Student(name: "Pawel", age: 22, studentID: "2213")
var arek = Professor(name: "Arek", age: 50, faculty: "Aviation")

pawel?.advisor = arek

var prz = University(name: "Prz", location: "Rzeszow")


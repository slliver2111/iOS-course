// A counter for tracking Student instances
actor StudentCounter {
    var counter = 0
    
    func increment() {
        counter += 1
    }
    
    func decrement() {
        counter -= 1
    }
    
    func getValue() -> Int {
        return counter
    }
}

// A counter for tracking Professor instances
actor ProfessorCounter {
    var counter = 0
    
    func increment() {
        counter += 1
    }
    
    func decrement() {
        counter -= 1
    }
    
    func getValue() -> Int {
        return counter
    }
}

class Person {
    let name: String
    let age: Int
    var isAdult: Bool {
        return age >= 18
    }
    static let minAgeForEnrollment = 16
    lazy var profileDescription: String = {
        return "\(self.name) is \(self.age) years old."
    }()
    
    // A designated initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // A failable initializer (fails if age is less than 16)
    init?(name: String, ageCheck age: Int) {
        guard age >= Person.minAgeForEnrollment else {
            print("Person init failed. Person need to be >= \(Person.minAgeForEnrollment)")
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
    
    // A required initializers
    required init(name: String, age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, age: age)
        Task{
            await studentCounter.increment()
        }
    }
    
    // Cover ageCheck feature
    init?(name: String, ageCheck age: Int, studentID: String) {
        self.studentID = studentID
        super.init(name: name, ageCheck: age)
        Task{
            await studentCounter.increment()
        }
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
    
    deinit {
        Task{
            await studentCounter.decrement()
            print("Student removed")
        }
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
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Task{
            await professorCounter.increment()
        }
    }
    
    // Cover ageCheck feature
    init?(name: String, ageCheck age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, ageCheck: age)
        Task{
            await professorCounter.increment()
        }
    }
    
    deinit {
        Task{
            await professorCounter.decrement()
            print("Professor removed")
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

// Global instance of counter actor
let studentCounter = StudentCounter()
let professorCounter = ProfessorCounter()

// TEST
let artur = Person(name: "Artur", age: 10)
let ola = Person(name: "Ola", age: 22)
let tomek = Person(name: "Tomek", ageCheck: 19)
let lukas = Person(name: "Lukas", ageCheck: 10) // Expected nil
let maciek = Student(name: "Maciek", age: 20, studentID: "01")
let marta = Student(name: "Marta", age: 20, studentID: "02", major: "IT")
var marek = Student(name: "Marek", ageCheck: 20, studentID: "00")
let romek = Student(name: "Romek", ageCheck: 10, studentID: "03") // Expected nil
let weronika = Student(name: "Weronika", ageCheck: 10, studentID: "04", major: "Medicine") // Expected nil

var pawel = Professor(name: "Pawel", ageCheck: 22, faculty: "History")
let prz = University(name: "Prz", location: "Rzeszow")

// TEST part 2
print(artur.isAdult)
print(ola.isAdult)

print(Student.minAgeForEnrollment)
print(ola.profileDescription)
print(maciek.profileDescription)

Task{ //async
    print("Number of students \(await Student.studentCount())") //Expected 3
}

Task{ //async
    try await Task.sleep(for: .seconds(3)) //Attempt to allow deinit task to be completed
    marek = nil
    try await Task.sleep(for: .milliseconds(100)) //Give short additional time
    print("Number of students \(await Student.studentCount())") // Expected 2
}

maciek.advisor = pawel
print(maciek.advisor?.fullTitle ?? "No advisor") // // Expected Prof. Hist Pawel

pawel = nil
print(maciek.advisor?.fullTitle ?? "No advisor") // Expected no advisor
print(marta.advisor?.fullTitle ?? "No advisor") // Expected no advisor

print(marta.formattedID)
print(prz.description)

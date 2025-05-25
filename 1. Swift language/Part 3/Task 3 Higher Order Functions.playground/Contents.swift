//What should be done
//*
//Steps:
//
//Define a struct called School that will house the primary functional elements of the school system.
//Inside the School struct, create a nested enum named SchoolRole with these cases: student, teacher, administrator.
//Define a nested class within the School struct called Person, which will have the following properties:
//name: A string indicating the person's name.
//role: A SchoolRole indicating the person's role in the school.
//Implement a subscript in the School struct to retrieve arrays of Person objects based on their SchoolRole. This will allow efficient access to categorized groups, such as all students or all teachers.
//Define new method in School addPerson(_ :)that will update its people list.
//Create three functions: countStudents, countTeachers, and countAdministrators. Each of these functions will:
//Take an instance of School as a parameter.
//Use the previously implemented subscript to access the list of Person instances by role.
//Return the count (type Int) of individuals for each respective role (students, teachers, administrators).
//In the answer provide url to repository and path to the source files with the implementation

struct School {
    var members: [Person] = []
    
    enum SchoolRole {
        case student, teacher, administrator
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    subscript(role: SchoolRole) -> [Person]{
        return members.filter{$0.role == role}
    }
    
    mutating func addPerson(_ newPerson: Person){
        self.members.append(newPerson)
    }
}

func countStudents(_ school: School) -> Int {
    return school[.student].count
}

func countTeachers(_ school: School) -> Int {
    return school[.teacher].count
}

func countAdministrators(_ school: School) -> Int {
    return school[.administrator].count
}


var mySchool = School()
mySchool.addPerson(School.Person(name: "Artur", role: .student))
mySchool.addPerson(School.Person(name: "Maciek", role: .student))
mySchool.addPerson(School.Person(name: "Krzysiek", role: .student))
mySchool.addPerson(School.Person(name: "Tomek", role: .administrator))
mySchool.addPerson(School.Person(name: "Zbyszek", role: .teacher))
mySchool.addPerson(School.Person(name: "Tadeusz", role: .teacher))

print("Number of students: \(countStudents(mySchool))") //Expected 3
print("Number of teachers: \(countTeachers(mySchool))") //Expected 2
print("Number of administrators: \(countAdministrators(mySchool))") //Expected 1

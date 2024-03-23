import Cocoa

/* Initializers */

struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"

/* Referring to the current instance */

struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

/* Lazy properties */

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person2 {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = Person2(name: "Ed")
ed.familyTree

/* Static properties and methods */

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        Student.classSize += 1
        self.name = name
    }
}

let ed2 = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)

/* Access control */

struct Person3 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed3 = Person3(id: "12345")

/* Structs summary */

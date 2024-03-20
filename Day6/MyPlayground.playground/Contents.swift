import Cocoa

/* Creating basic closures */

let driving = {
    print("I'm driving in my car")
}

driving()

/* Accepting parameters in a closure */

let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving2("London")

/* Returning values from a closure */

let driving3 = { (place: String) in
    print("I'm going to \(place) in my car")
}

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

/* Closures as parameters */

let driving4 = {
    print("I'm driving in my car")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving4)

/* Trailing closure syntax */

func travel2(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel2 {
    print("I'm driving in my car")
}

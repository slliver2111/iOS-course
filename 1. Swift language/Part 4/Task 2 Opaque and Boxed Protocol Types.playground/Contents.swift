//What should be done
//*
//Steps:
//
//1) Define a protocol Shape with methods area() and perimeter().
//
//2) Implement two classes, Circle and Rectangle, that conform to Shape.
//
//3) Implement a function generateShape that has Shape return type, but under hood creates a Circle with radius 5.
//
//4) Implement the function calculateShapeDetails that returns tuple of the area and perimeter of a shape.

protocol Shape{
    func area() -> Double
    func perimeter() -> Double
}


class Circle: Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * self.radius * self.radius
    }
    
    func perimeter() -> Double {
        return 2*Double.pi*self.radius
    }
}

class Rectangle: Shape {
    let side1: Double
    let side2: Double
    
    init(side1: Double, side2: Double) {
        self.side1 = side1
        self.side2 = side2
    }
    
    func area() -> Double {
        return side1 * side2
    }
    
    func perimeter() -> Double {
        return 2*(side1+side2)
    }
}


func generateShape() -> some Shape {
    var circle = Circle(radius: 5)
    return circle
}

///returns tuple (area, perimeter)
func calculateShapeDetails(_ shape: any Shape) -> (Double, Double) {
    return (shape.area(), shape.perimeter())
}


let circle1 = generateShape()
let rectange1 = Rectangle(side1: 20, side2: 30)

print(calculateShapeDetails(circle1))
print(calculateShapeDetails(rectange1))

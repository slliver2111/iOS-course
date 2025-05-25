//What should be done
//*
//Steps:
//
// 1) Create a generic class Stack that uses a type placeholder T.
// 2) Implement the following methods:
// 3) push(_ element: T): Adds an element to the stack.
// 4) pop() -> T?: Removes and returns the top element of the stack, or returns nil if the stack is empty.
// 5) size() -> Int: Returns the number of elements in the stack.
// 6) Implement a function printStackContents -> String that prints the elements of the stack.

class Stack<T> {
    private var items: [T] = []
    
    func push(_ newElement: T) {
        self.items.append(newElement)
    }
    
    func pop() -> T? {
        return items.popLast()
    }
    
    func size() -> Int {
        return items.count
    }
    
    func printStackContents() -> String {
        if items.isEmpty {
            return "Stack is empty"
        }
        
        var result: String = ""
        for item in items {
            result.append("\(String(describing: item))\n")
        }
        return result
    }
}

var test1 = Stack<Int>()
test1.push(11)
test1.push(22)
test1.push(33)
test1.push(44)
print("Size: \(test1.size())")
print("Pop thing \(String(describing: test1.pop()))")
print(test1.printStackContents())

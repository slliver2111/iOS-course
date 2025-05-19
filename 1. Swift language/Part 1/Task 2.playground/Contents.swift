//Write a function isBalancedParentheses(input: String) -> Bool that returns true if parentheses in a string are balanced, and false otherwise.
//public func isBalancedParentheses(input: String) -> Bool {
// Add you implmentation here
//return false
//}
//
//
//- Only parentheses () are considered; other brackets or characters should be ignored.
//- The input string might contain multiple lines.
//- For example, "(())" is balanced, but "(()" is not.
public func isBalancedParentheses(input: String) -> Bool {
    var openParentCount: Int = 0
    var closeParentCount: Int = 0
    
    // Iterate over string and count number of '(' and ')'.
    for char in input {
        switch char {
        case "(":
            openParentCount += 1
        case ")":
            closeParentCount += 1
            // Anytime ')' occurs more often return false
            guard closeParentCount <= openParentCount else {
                return false
            }
        default:
            continue
        }
    }
    // Number of '(' and ')' should be the same
    return openParentCount == closeParentCount
}


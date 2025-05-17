public func isBalancedParentheses(input: String) -> Bool {
    var openParentCount: Int = 0
    var closeParentCount: Int = 0
    
    for char in input {
        switch char {
        case "(":
            openParentCount += 1
        case ")":
            closeParentCount += 1
            guard closeParentCount <= openParentCount else {
                return false
            }
        default:
            continue
        }
    }
    return openParentCount == closeParentCount
}

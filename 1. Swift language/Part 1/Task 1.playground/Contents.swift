//Implement Palindrome Check Using String Manipulation. Create a function isPalindrome(input: String) -> Bool that checks whether a given string is a palindrome:
//
//
//public func isPalindrome(input: String) -> Bool {
//// Add you implmentation here
//return false
//}
// However, the trick is:
//- The solution should ignore spaces, punctuation, capitalization and control characters.
//- The solution should not use any third-party libraries or regular expressions.
//- The solution should not consider an empty string or a single character as a palindrome.
public func isPalindrome(input: String) -> Bool {
    // Helper function to identify C0, C1, and DEL control characters.
    func isControlCharacter(_ char: Character) -> Bool {
        guard let scalar = char.unicodeScalars.first else { return false }
        let value = scalar.value
        return (value >= 0x00 && value <= 0x1F) || (value >= 0x80 && value <= 0x9F) || value == 0x7F
    }

    let lowerInput = input.lowercased()
    var cleanChars: [Character] = []
    
    // Clean string by removing bad characters
    for char in lowerInput{
        if !char.isWhitespace &&
            !char.isPunctuation &&
            !isControlCharacter(char){
            cleanChars.append(char)
        }
    }
    
    let cleanString = String(cleanChars)
    
    // If there is only 1 character or nothing return false
    if cleanString.count <= 1{
        return false
    }
    
    // After cleaning if it is palindrome reversed string should match
    return cleanString == String(cleanString.reversed())
}


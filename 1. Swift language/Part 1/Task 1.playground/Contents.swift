/// Checks if a given string is a palindrome, adhering to specific cleaning rules.
///
/// The check ignores spaces, punctuation, capitalization, and control characters.
/// An empty string or a string that becomes empty or a single character after cleaning
/// is not considered a palindrome.
///
/// - Parameter input: The string to check.
/// - Returns: `true` if the cleaned string is a palindrome, otherwise `false`.
public func isPalindrome(input: String) -> Bool {
    // Helper function to identify C0, C1, and DEL control characters.
    func isControlCharacter(_ char: Character) -> Bool {
        guard let scalar = char.unicodeScalars.first else { return false }
        let value = scalar.value
        return (value >= 0x00 && value <= 0x1F) || (value >= 0x80 && value <= 0x9F) || value == 0x7F
    }

    let lowerInput = input.lowercased()
    var cleanChars: [Character] = []
    
    for char in lowerInput{
        if !char.isWhitespace &&
            !char.isPunctuation &&
            !isControlCharacter(char){
            cleanChars.append(char)
        }
    }
    
    let cleanString = String(cleanChars)
    
    if cleanString.count <= 1{
        return false
    }
    
    return cleanString == String(cleanString.reversed())
}


public func isPalindrome(input: String) -> Bool {
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


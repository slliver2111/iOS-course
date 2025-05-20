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

import Foundation

public func isPalindrome(input: String) -> Bool {
    // Lowercase
    let lowercasedString = input.lowercased()
    
    // Normalize string - remove diacritics using Foundation library
    let normalizedString = lowercasedString.folding(options: .diacriticInsensitive, locale: .current).lowercased()
    
    // Clean string by filtering only letters and numbers
    let cleanString = normalizedString.filter{ $0.isLetter || $0.isNumber }
    
    // If there is only 1 character or nothing function returns false
    if cleanString.count <= 1{
        return false
    }
    
    // After cleaning if it is palindrome reversed string should match
    return cleanString == String(cleanString.reversed())
}

//Steps:
//1. Define a User structure that contains:
//• username (String) - unique identifier for the user.
//• email (String) - required for user identification.
//• password (String) - stored securely (hashed for simplicity).
//2. Create a UserManager class to manage users, implementing:
//• A stored property users: [String: User] to store registered users.
//• A method registerUser(username:email:password:) -> Bool to register new users.
//• A method login(username:password:) -> Bool to verify credentials.
//• A method removeUser(username:) -> Bool to delete users.
//• A computed property userCount that returns the number of registered users.
//3. Implement inheritance by creating an AdminUser class that extends UserManager with additional functionality:
//• A method listAllUsers() -> [String] that returns a list of registered usernames.
//4. Use initialization to properly set up objects when created.
//5. Use deinitialization in AdminUser to print a message when an admin instance is removed from memory.

import Foundation

struct User{
    var username: String
    var email: String
    var password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}

class UserManager{
    private var registeredUsers: [String: User] = [:]
    var userCount: Int {
        registeredUsers.count
    }
    
    var usernames: [String] {
        Array(registeredUsers.keys)
    }
    
    func registerUser(username: String, email: String, password: String) -> Bool {
        // Check if username already exists
        guard registeredUsers[username.lowercased()] == nil else {
            print("User \(username) already exists!")
            return false
        }
        
        // Check if email already exists
        guard !registeredUsers.values.contains(where: {$0.email.lowercased() == email.lowercased() }) else {
            print("Email \(email) is already taken!")
            return false
        }
        
        // Create user in database
        registeredUsers[username.lowercased()] = User(
            username: username.lowercased(),
            email: email.lowercased(),
            password: password
        )
        
        print("User \(username) created succesfully!")
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        let userExists = registeredUsers[username.lowercased()] != nil
        
        // Check if username exists
        guard registeredUsers[username.lowercased()] != nil else {
            print("Username does not exist")
            return false
        }
        
        // Check if password is correct
        guard registeredUsers[username]?.password == password else {
            print("Incorrect password")
            return false
        }
        
        // All correct
        return true
    }
    
    func removeUser(username: String) -> Bool {
        guard registeredUsers.removeValue(forKey: username) != nil else {
            print("Error with removing user \(username)")
            return false
        }
        return true
    }
}


class AdminUser: UserManager{
    func listAllUsers() -> [String] {
        return usernames
    }
    
    deinit {
        print("Admin was removed")
    }
}

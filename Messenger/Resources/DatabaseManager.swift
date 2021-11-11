//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Shaiv Pandya on 11/10/21.
//

import Foundation
import FirebaseDatabase

final class Databasemanager {
    static let shared = Databasemanager()
    private let database = Database.database().reference()
}

// MARK: - Account Management

extension Databasemanager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    // let profilePictureUrl: String
}

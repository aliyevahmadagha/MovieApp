//
//  FireBaseHelper.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 29.01.25.
//

import FirebaseFirestore
import FirebaseAuth

final class FireBaseHelper {
    
    func register(email: String, password: String, completion: @escaping (UserDTO?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let user = authResult?.user {
                completion(.init(email: user.email ?? "", password: ""), nil)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (UserDTO?, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let user = authResult?.user {
                completion(.init(email: user.email ?? "", password: ""), nil)
            }
        }
    }
    
}



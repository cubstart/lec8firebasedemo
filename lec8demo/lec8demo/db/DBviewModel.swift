//
//  viewModel.swift
//  lec8demo
//
//  Created by Andy Huang on 10/26/23.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

class DBViewModel: ObservableObject {
    var db: Firestore!
    @Published var usersList: [User] = []
    
    init() {
        db = Firestore.firestore()
    }
    
    // --------------------- CREATE -----------------------
    
    /* ADD a new document under a random documentID. */
    func addUser(user: User) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        do {
            // Add new document
            try usersCollection.addDocument(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    /* ADD a new document with a specified documentID. */
    func addUser(user: User, documentID: String) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Define document ID.
        let newUserDocument = usersCollection.document(documentID)
        
        do {
            // Add new document.
            try newUserDocument.setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    // --------------------- READ --------------------------
    
    /* Get a user by document ID. */
    func getUser(documentID: String) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Define document ID.
        let userDocument = usersCollection.document(documentID)
        
        userDocument.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                print("User: \(user)")
                do {
                    try self.usersList.append(result.get())
                } catch {
                    print("Error getting \(user)")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
    }
    
    /* Get all documents in a collection. */
    func getAllUsers() {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Get all documents.
        usersCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let decodedUser = try document.data(as: User.self)
                        DispatchQueue.main.async {
                            self.usersList.append(decodedUser)
                        }
                        print(decodedUser)
                    } catch {
                        print("Error decoding \(document.data())")
                    }
                }
            }
        }
    }
    
    /* Get all users (documents) with the first name "Justin". */
    func getUsersNamedJustin() {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Query the collection.
        let filteredCollection = usersCollection.whereField("first_name", isEqualTo: "Justin")
        
        // Get queried documents.
        filteredCollection.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let decodedUser = try document.data(as: User.self)
                            self.usersList.append(decodedUser)
                        } catch {
                            print("Error decoding \(document.data())")
                        }
                    }
                }
        }
    }
    
    // --------------------- UPDATE --------------------------
    
    /* UPDATE an existing document. */
    func updateUser(documentID: String, fields: [String: Any]) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Define document ID.
        let userDocument = usersCollection.document(documentID)
        
        userDocument.updateData(fields) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    // --------------------- DELETE --------------------------
    
    /* DELETE an existing document. */
    func deleteUser(documentID: String) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Define document ID.
        let userDocument = usersCollection.document(documentID)
        
        userDocument.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    /* DELETE field(s) of an existing document.
     
     Example fields: ["last_name": FieldValue.delete()]
     */
    func deleteUserFields(documentID: String, fields: [String: Any]) {
        // Define collection.
        let usersCollection = db.collection("users")
        
        // Define document ID.
        let userDocument = usersCollection.document(documentID)
        
        userDocument.updateData(fields) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

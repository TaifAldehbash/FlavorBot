//
//  Model.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 10/06/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class FoodBotDB : ObservableObject {
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @Published var session: User?
    @Published var isAnon: Bool = false
    var handle: AuthStateDidChangeListenerHandle?
    
    //Session listner
    func listen() {
        handle = auth.addStateDidChangeListener({(auth, user) in
            if self.session != nil {
                self.isAnon = false
                self.session =  User(uid: self.session!.uid, name: self.session!.name, email: self.session!.email)
                print("Session \(String(describing: self.session))")
            } else {
                self.isAnon = true
                self.session = nil
            }
        })
    }
    
    
    //Sign in to user account using Auth
    func signIn(email : String , pass : String) -> Bool {
        self.auth.signIn(withEmail: email, password: pass) { authResult, error in
            if authResult != nil {
                self.db.collection("Users").whereField("UserId", isEqualTo: authResult!.user.uid)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting user details: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let doc = document.data()
                                self.session = User(uid: doc["UserId"] as! String, name: doc["Name"] as! String, email: doc["Email"] as! String)
                                print("Sign in user \(document.documentID) => \(doc)")
                            }
                        }
                    }
            }else{
                print("Error sign in : \(String(describing: error))")
            }
        }
        print(self.auth.currentUser!.email ?? "No user")
        return self.auth.currentUser!.email != nil
    }
    
    //Sign up to user account using Auth
    func signUp(name : String , email : String , pass : String) -> Bool {
        self.auth.createUser(withEmail: email, password: pass){(res, err) in
            if err == nil {
                self.db.collection("Users").addDocument(data: ["UserId" : res!.user.uid, "Name" : name, "Email" : email]){ err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        return
                    }
                }
            }else{
                print(err!)
            }
        }
        return signIn(email: email, pass: pass)
    }
    
    func signOut () -> Bool {
        do {
            try auth.signOut()
            self.session = nil
            self.isAnon = true
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            auth.removeStateDidChangeListener(handle)
        }
    }
}

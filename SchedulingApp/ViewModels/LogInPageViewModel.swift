//
//  LogInPageViewModel.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject {
    
    let manager = DB_Manager.instance
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @AppStorage("school_email") var schoolEmail: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("role") var role: String = ""
    
    @Published var FirstName: String = ""
    @Published var LastName: String = ""
    @Published var Email: String = ""
    @Published var UserPassword: String = ""
    
    @Published var Email_login: String = ""
    @Published var Password_login: String = ""
    
    @Published var signInAlert: Bool = false
    
    
    func addUser(email: String, fName: String, lName: String, role: String = "Student", password: String){
        let wasSuccessful = manager.addUser(newSchoolEmail: email, newFirstName: fName, newLastName: lName,newRole: role, newPassword: password)
        if (wasSuccessful){
            schoolEmail = email
            firstName = fName
            lastName = lName
            self.role = role
            currentUserSignedIn = true
        }else{
            signInAlert = true
        }
    }
    
    func checkIfUserExist(){
        let user = manager.checkUserExist(schoolEmail: Email_login, password: Password_login)
        if (user.firstName == "" && user.lastName == ""){
            currentUserSignedIn = false
        }else{
            schoolEmail = user.schoolEmail
            firstName = user.firstName
            lastName = user.lastName
            self.role = user.role
            currentUserSignedIn = true
        }
        
    }
    
    
}

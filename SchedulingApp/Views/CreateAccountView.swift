//
//  CreateAccountView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/17/23.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var loginvm: LoginViewModel
    var body: some View {
        VStack {
            VStack {
                formInputComponent(inputValue: $loginvm.Email, placeholder: "Enter Email...", formTitle: "Email")
                Spacer()
                    .frame(maxHeight: 20)
                formInputComponent(inputValue: $loginvm.FirstName, placeholder: "Enter First Name...", formTitle: "First Name")
                Spacer()
                    .frame(maxHeight: 20)
                formInputComponent(inputValue: $loginvm.LastName, placeholder: "Enter Last Name...", formTitle: "Last Name")
                Spacer()
                    .frame(maxHeight: 20)
                formInputComponent(inputValue: $loginvm.UserPassword, placeholder: "Enter Password...", formTitle: "Password")
                

                
            }.padding(.horizontal)
            HStack {
                Spacer()
                Button {
                    loginvm.addUser(email: loginvm.Email, fName: loginvm.FirstName, lName: loginvm.LastName, password: loginvm.UserPassword)
                } label: {
                    Text("Sign Up")
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                        .padding()
                        .background(Color("theme_red"))
                        .cornerRadius(50)
                }
            }
            .padding(.trailing)
            
            Spacer()
            
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(LoginViewModel())
    }
}

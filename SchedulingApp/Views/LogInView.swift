//
//  LogInView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import SwiftUI

struct LogInView: View {
    @StateObject var loginvm = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack{
                Spacer ()
                Image("banner_logo")
                    .resizable()
                    .frame(maxWidth:.infinity )
                    .frame(height: 40)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                
                VStack {
                    VStack(spacing: 0){
                        Text("Email")
                            .foregroundColor(Color("theme_red"))
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        TextField("Enter email...", text: $loginvm.Email_login)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("theme_red"), lineWidth: 1)
                            }

                    }
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    VStack(spacing: 0){
                        Text("Password")
                            .foregroundColor(Color("theme_red"))
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        TextField("Enter password...", text: $loginvm.Password_login)
                            .padding()
                            .background(.regularMaterial)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("theme_red"), lineWidth: 1)
                            }
                        HStack {
                            Spacer()
                            Button {
                                loginvm.checkIfUserExist()
                            } label: {
                                Text("Log in")
                                    .foregroundColor(Color("theme_red"))                        }
                            .padding()
                        }
                    }
                    
                }
                .padding(.horizontal)
                // MARK: TextField
                Spacer()
                
                ZStack {
                    Divider()
                        .padding()
                    Text("OR")
                        .foregroundColor(Color(UIColor.lightGray))
                        .font(.caption)
                        
                        .background(Color("bw"))
                }
                
                NavigationLink {
                    CreateAccountView()
                        //.environmentObject(loginvm)
                } label: {
                    Text("Create account")
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("theme_red"))
                        .cornerRadius(16)
                        .padding(.horizontal)
                }
                // MARK: Button
            }
            // MARK: VStack

            .navigationBarHidden(true)
        }
        .environmentObject(loginvm)
        .accentColor(Color("theme_red"))
        // MARK: NavigationView
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

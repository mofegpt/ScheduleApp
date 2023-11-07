//
//  SearchStudentView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/27/23.
//

import SwiftUI

struct SearchStudentView: View {
    @State private var showSheet = false
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    @State private var searchText = ""
    @State private  var fname = ""
    @State private var lname = ""
    @State private var schoolEmail = ""
    @State private var role = ""
    var body: some View {
        NavigationView {
            List{
                    ForEach(searchResults) { name in
                        HStack{
                            Text(name.schoolEmail)
                            Spacer()
                            Image(systemName: name.role.lowercased() == "student"  ?  "books.vertical.fill" : "person.fill").foregroundColor(Color("theme_red"))
                        }
                        .background(.white)
                        .onTapGesture {
                            showSheet.toggle()
                            bookroomsvm.profileClicked = name.schoolEmail
                            fname = name.firstName
                            lname = name.lastName
                            schoolEmail = name.schoolEmail
                            role = name.role
                        }
                    }
                }
                .searchable(text: $searchText)
                .sheet(isPresented: $showSheet) {
                    SearchProfileView(selection: role, fname: fname, lname: lname, schoolEmail: schoolEmail)
                }
                
        }
        .accentColor(Color("theme_red"))
    }
    var searchResults: [Users] {
        if searchText.isEmpty {
            return bookroomsvm.searchedUser
        } else {
            return bookroomsvm.searchedUser.filter{ $0.schoolEmail
                .contains(searchText)}
        }
    }
}

struct SearchStudentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchStudentView()
            .environmentObject(BookingRoomsViewModel())
    }
}

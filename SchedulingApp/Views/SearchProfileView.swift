//
//  SearchProfileView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/27/23.
//

import SwiftUI

struct SearchProfileView: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    @State var selection: String
    let roles = ["Student", "Staff"]
    var fname: String
    var lname: String
    var schoolEmail: String
    @State private var showSaveButton = false
    
    var body: some View {
        VStack() {
            HStack() {
                VStack(alignment: .leading){
                    HStack {
                        Text("First Name: ")
                            .bold()
                        Spacer()
                        Text(fname)
                    }
                    Divider()
                    HStack {
                        Text("Last Name: ")
                            .bold()
                        Spacer()
                        Text(lname)
                    }
                    Divider()
                    HStack {
                        Text("Email: ")
                            .bold()
                        Spacer()
                        Text(schoolEmail)
                    }
                    Divider()
                    HStack {
                        Text("Status: ")
                            .bold()
                        Spacer()
                        Picker("Select role", selection: $selection){
                            ForEach(roles, id:\.self){
                                Text($0)
                            }
                            
                        }
                        .accentColor(Color("theme_red"))
                        
                    }
                    
                    Divider()
                    HStack{
                        Spacer()
                        Button {
                            bookroomsvm.updateRole(role: selection, schoolEmail: schoolEmail)
                            
                        } label: {
                            if (showSaveButton == true){
                                Text("save")
                                    .bold()
                                    .font(.caption2)
                                    .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color("theme_red"))
                                    .cornerRadius(50)
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            ScrollView(showsIndicators: false){
                ForEach(bookroomsvm.searchedBookedAppointments){ value in
                    bookingDataComponent(building: value.building, room: value.roomID.description, school_email: value.schoolEmail, date: value.startTime, startTime: value.startTime, endTime: value.endTime)
                }
            }
            .onChange(of: selection) { _ in
                showSaveButton = true
            }
            .onAppear{
                bookroomsvm.viewProfileBookings()
            }
            
        }
    }
}

struct SearchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProfileView(selection: "Staff", fname: "LOL", lname: "LOL", schoolEmail: "LOL")
            .environmentObject(BookingRoomsViewModel())
    }
}

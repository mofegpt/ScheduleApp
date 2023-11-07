//
//  BookedAppointmentView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/12/23.
//

import SwiftUI

struct BookedAppointmentView: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                ForEach(bookroomsvm.bookedAppointments){ value in
                    bookingDataComponent(building: value.building, room: value.roomID.description, school_email: value.schoolEmail, date: value.startTime, startTime: value.startTime, endTime: value.endTime)
                    }
                }
            
            .navigationTitle("Bookings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.default) {
                            bookroomsvm.defaultButtonClicked.toggle()
                            bookroomsvm.message = "You want to sign out?"
                        }
                    } label: {
                        Text("sign out")
                            .bold()
                            .font(.caption2)
                            .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color("theme_red"))
                            .cornerRadius(50)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        PenaltyView()
                    } label: {
                        Image(systemName: "flag")
                    }
                }
                
                
            }
            
        }
        .onAppear{
            bookroomsvm.viewBookings()
        }
    }
}

struct BookedAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        //BookedAppointmentView()
        TabViews()
    }
}

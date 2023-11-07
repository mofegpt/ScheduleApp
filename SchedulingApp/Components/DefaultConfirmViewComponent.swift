//
//  DefaultConfirmViewComponent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/23/23.
//

import SwiftUI

struct DefaultConfirmViewComponent: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var message: String
    var body: some View {
        VStack {
            VStack {
                Text("Are you sure")
                Text(message)
            }
            .foregroundColor(.black)
            .padding()
            .background(.white)
            .cornerRadius(10)
            HStack {
                Button {
                    bookroomsvm.defaultButtonClicked.toggle()
                } label: {
                    Image(systemName: "hand.thumbsdown")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(Color("theme_red"))
                        .cornerRadius(10)
                }
                Button {
                    if (message == "You want to sign out?"){
                        bookroomsvm.signOut()
                    }else if (message == "You want to cancel booking?"){
                        bookroomsvm.removingAppointment(school_email: bookroomsvm.selectedSchoolEmail, start_time: bookroomsvm.selectedStartTime, end_time: bookroomsvm.selectedEndTime)
                    }
                    bookroomsvm.defaultButtonClicked.toggle()
                } label: {
                    Image(systemName: "hand.thumbsup")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(Color("theme_red"))
                        .cornerRadius(10)
                }
            }
            .foregroundColor(.white)
        }
        
    }
}

struct DefaultConfirmViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        DefaultConfirmViewComponent( message: "You want to sign out?")
            .environmentObject(BookingRoomsViewModel())
    }
}

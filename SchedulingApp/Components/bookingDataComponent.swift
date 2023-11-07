//
//  bookingComponent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/12/23.
//

import SwiftUI

struct bookingDataComponent: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var building: String
    var room: String
    var school_email: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(building)
                .bold()
            HStack {
                Text("Room")
                Text(room)
            }
            
            HStack(spacing: 5) {
                Text(date.formatted(date: .numeric, time: .omitted).description)
                    .font(.subheadline)
                Text(startTime.formatted(date: .omitted, time: .shortened).description)
                    .font(.subheadline)
                Text("-")
                    .font(.footnote)
                Text(endTime.formatted(date: .omitted, time: .shortened).description)
                    .font(.subheadline)
                Spacer()
                Button {
                    bookroomsvm.defaultButtonClicked.toggle()
                    bookroomsvm.bookingsToCancel(se: school_email, st: startTime.description, et: endTime.description)
                    bookroomsvm.message = "You want to cancel booking?"
                } label: {
                    Text("cancel booking")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.lightGray))
                }

            }
        }
        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("theme_red"))
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.vertical,5)
                
       
        
        
    }
}

struct bookingComponent_Previews: PreviewProvider {
    static var previews: some View {
        bookingDataComponent(building: "Student Union", room: "R94", school_email: "Mattew", date: Date.now, startTime: Date.now, endTime: Date.now)
        //TabViews()
    }
}

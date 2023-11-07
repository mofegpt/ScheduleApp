//
//  ConfirmPopUpComponent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/19/23.
//

import SwiftUI

struct ConfirmPopUpComponent: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var Building: String
    var Time: String
    var Room: String
    var Date: String
   
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .trailing){
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Text(Building)
                                .bold()
                                .foregroundColor(Color("theme_red"))
                            Text("Building")
                        }
                        HStack{
                            Text("Room")
                            Text(Room)
                                .bold()
                                .foregroundColor(Color("theme_red"))
                        }
                        HStack{
                            Text("On")
                            Text(Date)
                                .bold()
                                .foregroundColor(Color("theme_red"))
                        }
                        HStack{
                            Text("At")
                            Text(Time)
                                .bold()
                                .foregroundColor(Color("theme_red"))
                        }

                    }
                    .foregroundColor(.black)
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            
            Button {
                bookroomsvm.insertBookings()
                bookroomsvm.viewBookings()
                bookroomsvm.confirmedButtonClicked.toggle()
            } label: {
                Text("Book Appointment")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .background(Color("theme_red"))
                    .cornerRadius(10)
            }
            .foregroundColor(.white)
        }
    }
}

struct ConfirmPopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPopUpComponent(Building: "Student Union", Time: "1:30 - 2:00", Room: "R394", Date: "05/30/2023")
    }
}

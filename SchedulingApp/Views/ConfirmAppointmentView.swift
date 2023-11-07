//
//  confirmAppointmentView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/19/23.
//

import SwiftUI

struct ConfirmAppointmentView: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
                .opacity(0.7)
                .onTapGesture {
                    withAnimation(.default) {
                        bookroomsvm.confirmedButtonClicked.toggle()
                    }
                }
            
            ConfirmPopUpComponent(Building: bookroomsvm.selectedBuilding, Time: bookroomsvm.selectedTime.formatted(date: .omitted, time: .shortened).description, Room: bookroomsvm.selectedRoom, Date: bookroomsvm.selectedTime.formatted(date: .abbreviated, time: .omitted).description)
        }
    }
}

struct confirmAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAppointmentView()
            .environmentObject(BookingRoomsViewModel())
    }
}

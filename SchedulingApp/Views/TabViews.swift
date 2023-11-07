//
//  BookRoomView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import SwiftUI

struct TabViews: View {
    @StateObject var bookroomsvm = BookingRoomsViewModel()
    var body: some View {
        ZStack {
            
            TabView {
                BookRoomsView()
                    .tabItem {
                        Label("", systemImage: "house")
                    }
                BookedAppointmentView()
                    .tabItem {
                        Label("", systemImage: "book.closed")
                    }
            }
            .accentColor(Color("theme_red"))
            if(bookroomsvm.confirmedButtonClicked){
                ConfirmAppointmentView()
                    .ignoresSafeArea()
            } else if(bookroomsvm.defaultButtonClicked){
                ConfirmDefaultView()
                    .ignoresSafeArea()
            }
        }
        .environmentObject(bookroomsvm)
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}

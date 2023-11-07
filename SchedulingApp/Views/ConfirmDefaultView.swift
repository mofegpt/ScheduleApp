//
//  ConfirmDefaultView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/23/23.
//

import SwiftUI

struct ConfirmDefaultView: View {
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
                .opacity(0.7)
                .onTapGesture {
                    withAnimation(.default) {
                        bookroomsvm.defaultButtonClicked.toggle()
                    }
                }
            
            DefaultConfirmViewComponent(message: bookroomsvm.message)
        }
    }
}

struct ConfirmDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDefaultView()
            .environmentObject(BookingRoomsViewModel())
    }
}

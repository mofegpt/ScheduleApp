//
//  testView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 11/25/23.
//

import SwiftUI

struct ButtonPopUpComp: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 150, height: 150)
                .foregroundStyle(Color("theme_blue"))
                .overlay(alignment:.center) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                }
            Circle()
                .frame(width: 150, height: 150)
                .foregroundStyle(Color("theme_blue"))
                .overlay(alignment:.center) {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                }
            
        }
    }
}

#Preview {
    ButtonPopUpComp()
}

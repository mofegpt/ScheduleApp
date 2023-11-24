//
//  TabView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 11/20/23.
//

import SwiftUI

struct TabPageView: View {
    var body: some View {
        TabView {
            ReservationsView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            ReservationsView()
                .tabItem {
                    Label("", systemImage: "house")
                }
        }
    }
}

#Preview {
    TabPageView()
}

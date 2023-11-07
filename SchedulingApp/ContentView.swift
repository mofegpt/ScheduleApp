//
//
//  ContentView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool  = false
    var body: some View {
        VStack {
            if (!currentUserSignedIn){
                LogInView()
            }else{
                TabViews()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

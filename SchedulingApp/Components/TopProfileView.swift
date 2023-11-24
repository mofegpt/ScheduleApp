//
//  TopProfileVeiw.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 11/21/23.
//

import SwiftUI

struct TopProfileView: View {
    var body: some View {
        HStack(alignment:.top){
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment:.leading){
                Text("username")
                    .bold()
                Text("username@udmercy.edu")
                    .foregroundColor(.primary)
                
                Button {
                    
                } label: {
                    Text("Change Password")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.vertical,9)
                .background(Color("theme_blue"))
                .cornerRadius(8)

            }
        }
    }
}

#Preview {
    TopProfileView()
}

//
//  bubbleComponent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import SwiftUI

struct bubbleComponent: View {
    var text: String
    @State var bubbleColor: Color
    var body: some View {
        Text(text)
            .foregroundColor(Color.white)
            .padding(.horizontal, 13)
            .padding(.vertical, 10)
//            .padding(.horizontal)
            .background(bubbleColor)
            .cornerRadius(15)
    }
}

struct bubbleComponent_Previews: PreviewProvider {
    static var previews: some View {
        bubbleComponent(text: "Student Union", bubbleColor: Color("theme_red"))
        
    }
}

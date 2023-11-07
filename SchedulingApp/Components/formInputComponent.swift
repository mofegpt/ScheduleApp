//
//  formInputComponent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/17/23.
//

import SwiftUI

struct formInputComponent: View {
    @Binding var inputValue: String
    var placeholder :String
    var formTitle :String
    var body: some View {
        VStack(spacing: 0){
            Text(formTitle)
                .foregroundColor(Color("theme_red"))
                .font(.system(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            TextField(placeholder, text: $inputValue)
                .padding()
                .background(.regularMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("theme_red"), lineWidth: 1)
                }
        }
    }
}

struct formInputComponent_Previews: PreviewProvider {
    static var previews: some View {
        formInputComponent(inputValue: .constant(""), placeholder: "Enter password", formTitle: "Password")
    }
}

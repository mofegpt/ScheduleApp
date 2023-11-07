//
//  penaltyBubbleComponnent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/22/23.
//

import SwiftUI

struct penaltyBubbleComponnent: View {
    var date: String
    var comment: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(date)
                .bold()
            Text(comment)
        }
        .padding(.bottom)
        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("theme_red"))
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.vertical,5)
    }
}

struct penaltyBubbleComponnent_Previews: PreviewProvider {
    static var previews: some View {
        penaltyBubbleComponnent(date: Date.now.formatted( date: .numeric, time: .omitted), comment: "Littered the room in the student union")
    }
}

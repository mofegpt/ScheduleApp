//
//  PenaltyView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/22/23.
//

import SwiftUI

struct PenaltyView: View {
    var body: some View {
        VStack{
            ScrollView {
                ForEach(0..<9){_ in
                    penaltyBubbleComponnent(date: Date.now.formatted(date: .numeric, time: .omitted), comment: "Broken Tv in room 44")
                }
            }
        }
    }
}

struct PenaltyView_Previews: PreviewProvider {
    static var previews: some View {
        PenaltyView()
    }
}

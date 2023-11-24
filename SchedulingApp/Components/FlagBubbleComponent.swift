//
//  penaltyBubbleComponnent.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/22/23.
//

import SwiftUI

struct FlagBubbleComponent: View {
    var date: Date
    var comment: String
    var building: String
    var room: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(building)
                    .bold()
                Text("Room")
                Text(room)
                Spacer()
            }
            HStack(spacing: 5) {
                Text(getTodayWeekDay(date: date))
                    .font(.subheadline)
                Text(date.formatted(date: .numeric, time: .omitted).description)
                    .font(.subheadline)
                Text(date.formatted(date: .omitted, time: .shortened).description)
                    .font(.subheadline)
                Text("-")
                    .font(.footnote)
                Text(date.formatted(date: .omitted, time: .shortened).description)
                    .font(.subheadline)
                
                Spacer()
                
            }
            Text(comment)
        }
        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("theme_red"))
        .cornerRadius(20)
        
        
    }
    func getTodayWeekDay(date: Date) -> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           let weekDay = dateFormatter.string(from: date)
           return weekDay
     }
}

struct penaltyBubbleComponnent_Previews: PreviewProvider {
    static var previews: some View {
        FlagBubbleComponent(date: Date.now, comment: "Littered the room in the student union", building: "Student Union", room: "R57")
    }
}

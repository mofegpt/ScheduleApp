//
//  BookRoomsView.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/10/23.
//

import SwiftUI

struct BookRoomsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State private var showSheet = false
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var body: some View {
        VStack{
            PickRoomView
        }.onAppear{
            UIDatePicker.appearance().minuteInterval = 30
        }
        .sheet(isPresented: $showSheet) {
            SearchStudentView()
                .environmentObject(bookroomsvm)
        }
        
    }
}

struct BookRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        //BookRoomsView()
        TabViews()
    }
}

extension BookRoomsView{
    
    var PickRoomView: some View{
        NavigationView{
            VStack(alignment: .leading){
                // MARK: CHOOSE BUILDING
                OptionSelectionView(title: "Choose Building", options: $bookroomsvm.building)
                    .onAppear{
                        bookroomsvm.selectBuilding()
                    }
                
                Divider()
                    .background(Color("theme_red"))
                    .padding(.top, 5)
                // MARK: CHOOSE ROOM
                OptionSelectionView2(title: "Choose Room", options:  $bookroomsvm.rooms)
                Divider()
                    .background(Color("theme_red"))
                    .padding(.top, 5)
                DatePicker(
                    "Choose Date",
                    selection: $bookroomsvm.selectedTime,
                    in: Date.now...,
                    displayedComponents: [.date]
                )
                .padding(.horizontal)
                Text("Choose Time")
                    .padding()
                HStack {
                    DatePicker("", selection: $bookroomsvm.selectedTime, in: Date.now..., displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        //.clipped()
                    
                }
                .frame(maxWidth: .infinity)
                
                Text("Time Unavailable")
                    .padding(.horizontal)
                HStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(bookroomsvm.unAvailTime, id: \.self){ value in
                                    bubbleComponent(text: value.formatted(date: .abbreviated, time: .shortened), bubbleColor: Color("theme_red"))
    
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                //.frame(maxWidth: .infinity)
                //.background(.pink)
                Spacer()
            }

            
                    .navigationTitle("Book Room")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                withAnimation(.default) {
                                    bookroomsvm.confirmedButtonClicked.toggle()
                                }
                            } label: {
                                Text("confirm")
                                    .bold()
                                    .font(.caption2)
                                    .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color("theme_red"))
                                    .cornerRadius(50)
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            if(bookroomsvm.role.lowercased() == "staff"){
                                Button {
                                    showSheet.toggle()
                                    bookroomsvm.getUsers()
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                }
                                
                                //                            NavigationLink {
                                //                                PenaltyView()
                                //                            } label: {
                                //                                Image(systemName: "magnifyingglass")
                                //                            }
                            }
                        }
                }
        }
    }
}


struct OptionSelectionView: View{
    @State var title: String
    @Binding var options: [String]
    @State var isClicked = false
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var body: some View{
        HStack {
            Text(title)
                .padding(.vertical)
            Spacer()
        }
        .padding(.horizontal)
        ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 0){
                    ForEach(options, id: \.self){value in
                        withAnimation(.easeIn) {
                            Button {
                                isClicked.toggle()
                                bookroomsvm.getRooms(building: value)
                                bookroomsvm.selectedBuilding = value

                            } label: {
                                bubbleComponent(text: value, bubbleColor: Color(UIColor.lightGray))
                                    .padding(.horizontal, 5)
                            }
                        }
                }
            }
        }
    }
}

struct OptionSelectionView2: View{
    @State var title: String
    @Binding var options: [String]
    @State var isClicked = false
    @EnvironmentObject var bookroomsvm: BookingRoomsViewModel
    var body: some View{
        HStack {
            Text(title)
                .padding(.vertical)
            Spacer()
        }
        .padding(.horizontal)
        ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 0){
                    ForEach(options, id: \.self){value in
                    Button {
                        bookroomsvm.selectedRoom = value
                        isClicked.toggle()
                        if(!bookroomsvm.selectedRoom.isEmpty){
                            bookroomsvm.getUnavailTime()
                        }
                    } label: {
                        bubbleComponent(text: value, bubbleColor: Color(UIColor.lightGray))
                            .padding(.horizontal, 5)
                    }
                }
            }
        }
    }
}




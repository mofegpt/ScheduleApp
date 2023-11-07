//
//  BookingRoomsViewModel.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/11/23.
//

import Foundation
import SwiftUI

class BookingRoomsViewModel: ObservableObject {
    
    let manager = DB_Manager.instance
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @AppStorage("school_email") var schoolEmail: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("role") var role: String = ""
    
    // school_email: school_email, start_time: startTime.description, end_time: endTime.description
    @Published var selectedSchoolEmail: String = ""
    @Published var selectedStartTime: String = ""
    @Published var selectedEndTime: String = ""
     
    func bookingsToCancel(se: String, st: String, et: String){
        selectedSchoolEmail = se
        selectedStartTime = st
        selectedEndTime = et
    }
    
    
     let columns: [GridItem] = [
        GridItem(.flexible(),spacing: 30, alignment: nil),
        GridItem(.flexible(),spacing: 30, alignment: nil),
        GridItem(.flexible(),spacing: 30, alignment: nil)
    ]
    

    let FORMAT: Date.FormatStyle = .dateTime.day().month().year()
    let FORMATTIME: Date.FormatStyle.TimeStyle = .shortened
    
    @Published var confirmedButtonClicked: Bool = false
    @Published var defaultButtonClicked: Bool = false
    @Published var message: String = ""
    
    @Published var building: [String] = []
    @Published var rooms: [String] = []
    
    
    
    @Published var selectedBuilding: String = ""
    @Published var selectedRoom: String = ""
    @Published var selectedDate: Date = Date.now
    @Published var selectedTime: Date = Date.now
    
    @Published var searchedUser: [Users] = []
    
    @Published var bookedAppointments: [Bookings] = []
    @Published var searchedBookedAppointments: [Bookings] = []
    @Published var unAvailTime: [Date] = []
    
    @Published var profileClicked: String =  ""
    
    
    func selectBuilding(){
       building =  manager.getBuildings()
    }
    
    func getRooms(building: String){
        rooms = manager.getRooms(building: building)
    }
    
    func getUsers(){
            self.searchedUser = self.manager.getUser()
    }
    
    func insertBookings(){
        manager.insertBookings(roomID: Int(selectedRoom)!, schoolEmail: schoolEmail, startTime: selectedTime, endTime: selectedTime.addingTimeInterval(30*60), dateBooked: Date.now)
    }
    
    func viewBookings(){
            bookedAppointments = manager.viewBooked(schoolEmail: schoolEmail)
    }
    
    func viewProfileBookings(){
       searchedBookedAppointments =  manager.viewBooked(schoolEmail: profileClicked)
    }
    
    func removingAppointment(school_email: String, start_time: String, end_time: String){
        manager.removeBooking(schoolEmail: school_email, startTime: start_time, endTime: end_time)
        viewBookings()
    }
    func updateRole(role: String, schoolEmail: String){
        self.role = role
        manager.updateRole(role: role, schoolEmail: schoolEmail)
    }
    func getUnavailTime(){
        var dates: [Date] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd HH':'mm':'ssZZZ"
        for string in manager.getUnavailableTime(roomSelected: Int(selectedRoom)!){
            dates.append(dateFormatter.date(from:string)!)
        }
        
        unAvailTime = dates
    }
    
    func signOut(){
        schoolEmail = ""
        firstName = ""
        lastName = ""
        role  = ""
        currentUserSignedIn = false
    }
}

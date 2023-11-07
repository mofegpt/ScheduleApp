//
//  UserModel.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/17/23.
//

import Foundation

class UserModel: Identifiable{
    public var schoolEmail: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var role: String = ""
    public var password: String = ""
}

struct Bookings: Identifiable{
    public var id = UUID().uuidString
    public var building = ""
    public var roomID: Int64 = 0
    public var schoolEmail: String = ""
    public var startTime: Date = Date.now
    public var endTime: Date = Date.now
    public var dateBooked: Date = Date.now
    
}


struct Users: Identifiable{
    public var id = UUID().uuidString
    public var schoolEmail: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var role: String = ""
    public var password: String = ""
}

//
//  DB_Manager.swift
//  SchedulingApp
//
//  Created by Eyimofe Oladipo on 4/17/23.
//

import Foundation


import SQLite


class DB_Manager{
    
    static let instance = DB_Manager() // Singleton
    
    // Sqlite instance
    private var db: Connection!
    private var users: Table!
    
    // Instance of table
    private var schoolEmail: Expression<String>!
    private var firstName: Expression<String>!
    private var lastName: Expression<String>!
    private var role: Expression<String>!
    private var password: Expression<String>!
    
    // constructor of this class
    init(){
            createConnection()
            createBookTable(db: db)
            createRooms(db: db)
            insertRoom(db: db)
            createFakeUsers()
        
    }
    
    public func addUser(newSchoolEmail: String, newFirstName: String, newLastName: String, newRole: String, newPassword: String) -> Bool{
        do{
            try db.run(users.insert(schoolEmail <- newSchoolEmail, firstName <- newFirstName,lastName <- newLastName, role <- newRole, password <- newPassword))
            // INSERT INTO "users" ("schoolEmail", "firstName", "lastName", "role", "password") VALUES (?,?,?,?,?)
            return true
        } catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    
    public func createFakeUsers(){
        do{
            let insertUsers = try db.prepare("INSERT INTO users (schoolEmail, first_name, last_name, role, password) VALUES(\"mofe@udmercy.edu\", \"mofe\", \"oladipo\", \"student\", \"mofe\"),(\"john@udmercy.edu\", \"john\", \"roseman\", \"student\", \"john\"),(\"mohammed@udmercy.edu\", \"mohammed\", \"saeed\", \"student\", \"mohammed\"), (\"adam@udmercy.edu\", \"adam\", \"hollman\", \"staff\", \"adam\")")
            try insertUsers.run()
        
        }catch{
            print(" Error creating fake database: \(error.localizedDescription)")
        }
    }
    
    public func getUser() -> [Users]{
        var users: [Users] = []
            do{
                
                for row in try self.db.prepare("SELECT * FROM users"){
                        users.append(Users(schoolEmail: row[0]! as! String, firstName: row[1]! as! String, lastName: row[2]! as! String, role: row[3]! as! String))
                    print(row[0]!)
                }
            }catch{
                print("Error getting users: \(error.localizedDescription)")
            }
        return users
    }
    
    public func checkUserExist(schoolEmail: String, password: String) -> UserModel{
        let loginUser: UserModel = UserModel()
        do{
            for row in try db.prepare("SELECT * FROM users WHERE schoolEmail = \"\(schoolEmail)\" and password = \"\(password)\""){
                loginUser.schoolEmail = row[0]! as! String
                loginUser.firstName = row[1]! as! String
                loginUser.lastName = row[2]! as! String
                loginUser.role = row[3]! as! String
                loginUser.password = row[4]! as! String
                
                //unavailableTime.append(row[0]! as! String)
            }
        } catch {
            print("Error checking User exist : \(error.localizedDescription)")
        }
        return loginUser
    }
    
    public func getBuildings() -> [String]{
        var buildings: [String] = []
        do{
            for row in try db.prepare("SELECT DISTINCT building from Rooms GROUP BY building"){
                buildings.append(row[0]! as! String)
                print(row[0]!)
            }
            
        } catch {
            print("Get Building: \(error.localizedDescription)")
        }
        return buildings
    }
    
    public func getRooms(building: String) -> [String]{
        var rooms: [String] = []
        do{
            for row in try db.prepare("SELECT roomID FROM Rooms WHERE building = \"\(building)\""){
                let val: Int64 = row[0]! as! Int64
                rooms.append(val.description)
                print(row[0]!)
            }
            
        } catch {
            print("Get Room: \(error.localizedDescription)")
        }
        return rooms
    }
    
    private func createRooms(db: Connection!){
        do{
            let createRoom = try db.prepare("create table if not exists Rooms( roomID int, building text, vacancy text, primary key (roomID, building));")
            try createRoom.run()
            
        }catch{
            print( "Error creating room \(error.localizedDescription)")
        }
        
    }
    private func insertRoom(db: Connection!){
        do{
            let insertRoom = try db.prepare("INSERT INTO Rooms (roomID, building, vacancy) VALUES (57, \"Chemistry Building\",\"open\"), (58, \"Student Union\",\"open\"),(59, \"Student Center\",\"open\"),(90, \"Student Center\",\"open\"),(70, \"Chemistry Building\",\"open\"), (48, \"Student Union\",\"open\");")
            try insertRoom.run()
        }catch{
            print("Error inserting to room \(error.localizedDescription)")
        }
    }
    
    private func createBookTable(db: Connection!){
        do{
            let table = try db.prepare("CREATE TABLE if not exists Bookings( roomID int, schoolEmail text, startTime time, endTime time, dateBooked date, PRIMARY KEY (roomID, schoolEmail, startTime, endTime));")
            try table.run()
        }catch{
            print("Error Creating book table \(error.localizedDescription)")
        }
    }
    
    func insertBookings(roomID: Int, schoolEmail: String, startTime: Date, endTime: Date, dateBooked: Date){
        do{
            let table = try db.prepare("INSERT INTO Bookings(roomID, schoolEmail, startTime, endTime, dateBooked) VALUES ( \(roomID), \"\(schoolEmail)\", \"\(startTime)\", \"\(endTime)\" , \"\(dateBooked)\")")
            try table.run()
        }catch{
            print("Error inserting Bookings \(error.localizedDescription)")
        }
    }
    
    func getUnavailableTime(roomSelected: Int) -> [String]{
        var unavailableTime: [String] = []
        do{
            for row in try db.prepare("SELECT startTime FROM Bookings WHERE startTime > \'\(Date.now)\' and RoomID = \(roomSelected)"){
                unavailableTime.append(row[0]! as! String)
            }
        } catch {
            print("Error getting unavailable time: \(error.localizedDescription)")
        }
        return unavailableTime
    }
    
    func viewBooked(schoolEmail: String) -> [Bookings] {
        var bookedRooms: [Bookings] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd HH':'mm':'ssZZZ"
        do{
            for row in try db.prepare("SELECT B.* , R.building FROM Bookings as B, Rooms as R WHERE schoolEmail =  \"\(schoolEmail)\" and B.roomID = R.roomID and B.endTime > \'\(Date.now)\'"){
                let roomId: Int64 = row[0] as! Int64
                let email: String = row[1] as! String
                let startTimeString: String = row[2] as! String
                let building: String = row[5] as! String
                
                let startTime = dateFormatter.date(from:startTimeString)!
                let endTimeString: String = row[3] as! String
                let endTime = dateFormatter.date(from: endTimeString)!
                let dateBookedString = row[4] as! String
                let dateBook =  dateFormatter.date(from:dateBookedString)!
                

                bookedRooms.append(Bookings(building:building , roomID: roomId, schoolEmail: email, startTime: startTime, endTime: endTime, dateBooked: dateBook))
            }
        }catch{
            
        }
       return bookedRooms
    }
    
    func removeBooking(schoolEmail: String, startTime: String, endTime: String){
        do{
            let delete = try db.prepare("DELETE FROM Bookings WHERE schoolEmail = \"\(schoolEmail)\" AND startTime = \'\(startTime)\' AND endTime = \'\(endTime)\'")
            try delete.run()
        }catch{
            print("Error removing bookings: \(error.localizedDescription)")
        }
    }
    
    func updateRole(role: String, schoolEmail: String){
        do{
            let update = try db.prepare("UPDATE users SET role = \"\(role)\" WHERE schoolEmail = \"\(schoolEmail)\"")
            try update.run()
        }catch{
            print("Error updating roles: \(error.localizedDescription)")
        }
    }
    
    private func createConnection(){
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            print(path)
            db = try Connection ("\(path)/schedulingDB.sqlite3")
            
            // create table object
            users = Table("users")
            // Create instances of each column
            schoolEmail = Expression<String>("schoolEmail")
            firstName = Expression<String>("first_name")
            lastName = Expression<String>("last_name")
            role = Expression<String>("role")
            password = Expression<String>("password")
            
            // Check if the table exist
            if(!UserDefaults.standard.bool(forKey: "is_db_created")){
                try db.run(users.create{ (t) in
                    t.column(schoolEmail, primaryKey: true)
                    t.column(firstName)
                    t.column(lastName)
                    t.column(role)
                    t.column(password)
                })
                // CREATE TABLE "users" (
                //     "schoolEmail" INTEGER PRIMARY KEY NOT NULL,
                //     "firstName" TEXT,
                //     "lastName" TEXT,
                //     "role" TEXT,
                // )
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        }catch{
            print("Error creating user table \(error.localizedDescription)")
        }
    }
}

//
//  PeopleModels.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

struct PersonList {
    struct Request {
        var needsNetworkLoad: Bool
    }
    
    struct Response {
        var personList: [Person.Response]
    }
    
    struct ViewModel {
        var personList: [Person.ViewModel]
    }
}

struct Person {
    struct Response {
        var id: Int
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: Int
    }
    
    struct ViewModel {
        var fullName: String
        var organizationName: String
        var followers: String
    }
}

final class PersonListRemote: NSObject, Codable, RemoteObjectProtocol, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var success: Bool
    var data: [PersonRemote]
    
    enum CodingKeys: String, CodingKey {
      case success
      case data
    }
    
    init(success: Bool, data: [PersonRemote]) {
        self.success = success
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        data = try container.decode([PersonRemote].self, forKey: .data)
    }
    
    convenience init?(coder: NSCoder) {
        let success = coder.decodeBool(forKey: "success")
        let data = coder.decodeObject(forKey: "data") as! Data
        
        guard let arrayData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [PersonRemote] else {
            return nil
        }
        
        self.init(success: success, data: arrayData)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(success, forKey: "success")
        
        guard let arrayData = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                requiringSecureCoding: false) else { return }
        
        coder.encode(arrayData, forKey: "data")
    }
}

final class PersonRemote: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var id: Int
    var firstName: String
    var lastName: String
    var orgName: String
    var followersCount: Int
    
    init(id: Int, firstName: String, lastName: String, orgName: String, followersCount: Int) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.orgName = orgName
        self.followersCount = followersCount
    }
    
    convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let firstName = coder.decodeObject(forKey: "firstName") as! String
        let lastName = coder.decodeObject(forKey: "lastName") as! String
        let orgName = coder.decodeObject(forKey: "orgName") as! String
        let followersCount = coder.decodeInteger(forKey: "followersCount")
        
        self.init(id: id,
                  firstName: firstName,
                  lastName: lastName,
                  orgName: orgName,
                  followersCount: followersCount)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(orgName, forKey: "orgName")
        coder.encode(followersCount, forKey: "followersCount")
    }
}

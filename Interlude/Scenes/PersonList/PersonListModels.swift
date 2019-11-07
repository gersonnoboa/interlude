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
        var isFromPullToRefresh: Bool
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
        var pictureURL: String?
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
    
    enum RootCodingKeys: CodingKey {
        case id
        case first_name
        case last_name
        case org_name
        case followers_count
        case picture_id
        case open_deals_count
        case closed_deals_count
        case active_flag
        case update_time
        case cc_email
    }
    
    enum PictureIdCodingKeys: CodingKey {
        case pictures
    }
    
    enum PictureSizeCodingKeys: String, CodingKey {
        case small = "128"
    }
    
    var id: Int
    var firstName: String
    var lastName: String
    var orgName: String
    var followersCount: Int
    var pictureURL: String?
    var openDealsCount: Int
    var closedDealsCount: Int
    var isActive: Bool
    var lastUpdated: String
    var email: String
    
    init(id: Int,
         firstName: String,
         lastName: String,
         orgName: String,
         followersCount: Int,
         pictureURL: String?,
         openDealsCount: Int,
         closedDealsCount: Int,
         isActive: Bool,
         lastUpdated: String,
         email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.orgName = orgName
        self.followersCount = followersCount
        self.pictureURL = pictureURL
        self.openDealsCount = openDealsCount
        self.closedDealsCount = closedDealsCount
        self.isActive = isActive
        self.lastUpdated = lastUpdated
        self.email = email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .first_name)
        lastName = try container.decode(String.self, forKey: .last_name)
        orgName = try container.decode(String.self, forKey: .org_name)
        followersCount = try container.decode(Int.self, forKey: .followers_count)
        openDealsCount = try container.decode(Int.self, forKey: .open_deals_count)
        closedDealsCount = try container.decode(Int.self, forKey: .closed_deals_count)
        isActive = try container.decode(Bool.self, forKey: .active_flag)
        lastUpdated = try container.decode(String.self, forKey: .update_time)
        email = try container.decode(String.self, forKey: .cc_email)
        
        
        let pictureIdContainer = try? container.nestedContainer(keyedBy: PictureIdCodingKeys.self, forKey: .picture_id)
        let pictureSizeContainer = try? pictureIdContainer?.nestedContainer(keyedBy: PictureSizeCodingKeys.self, forKey: .pictures)
        pictureURL = try? pictureSizeContainer?.decode(String?.self, forKey: .small)
    }
    
    convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: RootCodingKeys.id.stringValue)
        let firstName = coder.decodeObject(forKey: RootCodingKeys.first_name.stringValue) as? String ?? ""
        let lastName = coder.decodeObject(forKey: RootCodingKeys.last_name.stringValue) as? String ?? ""
        let orgName = coder.decodeObject(forKey: RootCodingKeys.org_name.stringValue) as? String ?? ""
        let followersCount = coder.decodeInteger(forKey: RootCodingKeys.followers_count.stringValue)
        let pictureURL = coder.decodeObject(forKey: RootCodingKeys.picture_id.stringValue) as? String ?? ""
        let openDealsCount = coder.decodeInteger(forKey: RootCodingKeys.open_deals_count.stringValue)
        let closedDealsCount = coder.decodeInteger(forKey: RootCodingKeys.closed_deals_count.stringValue)
        let isActive = coder.decodeBool(forKey: RootCodingKeys.active_flag.stringValue)
        let lastUpdated = coder.decodeObject(forKey: RootCodingKeys.update_time.stringValue) as? String ?? ""
        let email = coder.decodeObject(forKey: RootCodingKeys.cc_email.stringValue) as? String ?? ""
        
        self.init(id: id,
                  firstName: firstName,
                  lastName: lastName,
                  orgName: orgName,
                  followersCount: followersCount,
                  pictureURL: pictureURL,
                  openDealsCount: openDealsCount,
                  closedDealsCount: closedDealsCount,
                  isActive: isActive,
                  lastUpdated: lastUpdated,
                  email: email)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: RootCodingKeys.id.stringValue)
        coder.encode(firstName, forKey: RootCodingKeys.first_name.stringValue)
        coder.encode(lastName, forKey: RootCodingKeys.last_name.stringValue)
        coder.encode(orgName, forKey: RootCodingKeys.org_name.stringValue)
        coder.encode(followersCount, forKey: RootCodingKeys.followers_count.stringValue)
        coder.encode(pictureURL, forKey: RootCodingKeys.picture_id.stringValue)
        coder.encode(openDealsCount, forKey: RootCodingKeys.open_deals_count.stringValue)
        coder.encode(closedDealsCount, forKey: RootCodingKeys.closed_deals_count.stringValue)
        coder.encode(isActive, forKey: RootCodingKeys.active_flag.stringValue)
        coder.encode(lastUpdated, forKey: RootCodingKeys.update_time.stringValue)
        coder.encode(email, forKey: RootCodingKeys.cc_email.stringValue)
    }
}

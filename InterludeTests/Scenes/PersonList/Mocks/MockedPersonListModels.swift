//
//  MockedPersonListModels.swift
//  InterludeTests
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedPersonListModels {
    static var personListResponse: PersonList.Response {
        let person = Person.Response(id: 1, firstName: "Gerson", lastName: "Noboa", organizationName: "Pipedrive", followers: 2010, pictureURL: "https://cms.pipedriveassets.com/Bootcamp-July-group.jpg")
        
        return PersonList.Response(personList: [person])
    }
}

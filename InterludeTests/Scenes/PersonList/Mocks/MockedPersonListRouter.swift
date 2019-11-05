//
//  MockedPersonListRouter.swift
//  InterludeTests
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit
@testable import Interlude

final class MockedPersonListRouter: PersonListRouterProtocol {
    var spy_navigateToPersonDetailsCalled: Bool = false
    
    func navigateToPersonDetails() {
        spy_navigateToPersonDetailsCalled = true
    }
    
    func passDataToNextScene(using segue: UIStoryboardSegue) { }
}

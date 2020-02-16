//
//  OpenImageUITest.swift
//  Reddit_testUITests
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest

class OpenImageUITest: UITestCase {
    func testOpenImageFlow() {
        let topicsListPage = TopicsListPage()
        let imageViewForCell2 = topicsListPage.imageWithAtIndex(2)
        imageViewForCell2.waitUntilExists()
        topicsListPage.openFullScreenImage(2) { imagePage in
            let saveButton = imagePage.saveButton()
            saveButton.waitUntilExists()
            RunLoop.wait { saveButton.isEnabled }
            RedditApp.shared.wait(forInterval: .short)
            
            saveButton.tap()
            RunLoop.wait { imagePage.saveButton().exists }
            imagePage.close()
            RedditApp.shared.wait(forInterval: .short)
        }
        
        let imageViewForCell3 = topicsListPage.imageWithAtIndex(3)
        imageViewForCell3.waitUntilExists()
    }
}

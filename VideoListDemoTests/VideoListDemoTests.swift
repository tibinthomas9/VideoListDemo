//
//  VideoListDemoTests.swift
//  VideoListDemoTests
//
//  Created by Tibin Thomas on 23/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import XCTest
import DataFetcher
@testable import VideoListDemo

class VideoListDemoTests: XCTestCase {
    var sut: ContentListingViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentListingVC") as? ContentListingViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testIsLoadingCell() {
        let indexPath = IndexPath(row: 1, section: 0)
        XCTAssertTrue(sut.isLoadingCell(for: indexPath))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        if let url = Bundle.main.url(forResource: "CONTENTLISTINGPAGE-PAGE1)", withExtension: "json"){
            let request = JsonRequest<ContentBaseModel>.init(url: url)
        self.measure {
            // Put the code you want to measure the time of here.
            request.load(withCompletion: { (model) in

            })
        }
        }
    }

}

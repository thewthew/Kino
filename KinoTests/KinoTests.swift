//
//  KinoTests.swift
//  KinoTests
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Kino

class KinoTests: XCTestCase {
    var stubs: [OHHTTPStubsDescriptor] = []

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        removeAllStubs()
        super.tearDown()
    }
    func removeAllStubs() {
        stubs.forEach { (stubDescriptor) in
            OHHTTPStubs.removeStub(stubDescriptor)
        }
    }
    func stubWebService(for endpoint: String, with jsonStr: String, statusCode: Int32 = 200) {
        let myStub = stub(condition: { (request) in
            return request.url?.path.hasSuffix(endpoint) ?? false
        }, response: { (_) -> OHHTTPStubsResponse in
            guard let stubData = jsonStr.data(using: .utf8) else {
                fatalError("\(#function) - Stub failed to parse string \(jsonStr) to data")
            }
            return OHHTTPStubsResponse(data: stubData,
                                       statusCode: statusCode,
                                       headers: ["Content-Type": "application/json"])
        })

        myStub.name = endpoint
        stubs.append(myStub)
    }

}

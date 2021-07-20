//
//  MapFeatureOnboardingViewTests.swift
//  SwiftUIExampleAppTests
//
//  Created by Tyler Thompson on 7/15/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import XCTest
import SwiftUI
import Swinject
import ViewInspector

@testable import SwiftCurrent_SwiftUI // 🤮 it sucks that this is necessary
@testable import SwiftUIExampleApp

final class MapFeatureOnboardingViewTests: XCTestCase {
    let defaultsKey = "OnboardedToMapFeature"
    override func setUpWithError() throws {
        Container.default.removeAll()
    }

    #warning("Pipeline has a really hard time with this, even though locally it continues to work great, replacement test below this test.")
    func testOnboardingInWorkflow() throws {
        let defaults = try XCTUnwrap(UserDefaults(suiteName: #function))
        defaults.set(false, forKey: defaultsKey)
        Container.default.register(UserDefaults.self) { _ in defaults }
        let workflowFinished = expectation(description: "View Proceeded")
        let exp = ViewHosting.loadView(WorkflowView(isLaunched: .constant(true))
                                        .thenProceed(with: WorkflowItem(MapFeatureOnboardingView.self))
                                        .onFinish { _ in
                                            workflowFinished.fulfill()
                                        }).inspection.inspect { view in
                                            XCTAssertNoThrow(try view.find(ViewType.Text.self))
                                            XCTAssertEqual(try view.find(ViewType.Text.self).string(), "Learn about our awesome map feature!")
                                            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
                                        }
        wait(for: [exp, workflowFinished], timeout: TestConstant.timeout)
    }

    func testOnboardingViewLoads_WhenNoValueIsInUserDefaults() throws {
        let defaults = try XCTUnwrap(UserDefaults(suiteName: #function))
        defaults.removeObject(forKey: defaultsKey)
        Container.default.register(UserDefaults.self) { _ in defaults }
        XCTAssert(MapFeatureOnboardingView().shouldLoad(), "Profile onboarding should show if defaults do not exist")
    }

    func testOnboardingViewLoads_WhenValueInUserDefaultsIsFalse() throws {
        let defaults = try XCTUnwrap(UserDefaults(suiteName: #function))
        defaults.set(false, forKey: defaultsKey)
        Container.default.register(UserDefaults.self) { _ in defaults }
        XCTAssert(MapFeatureOnboardingView().shouldLoad(), "Profile onboarding should show if default is false")
    }

    func testOnboardingViewDoesNotLoad_WhenValueInUserDefaultsIsTrue() throws {
        let defaults = try XCTUnwrap(UserDefaults(suiteName: #function))
        defaults.set(true, forKey: defaultsKey)
        Container.default.register(UserDefaults.self) { _ in defaults }
        XCTAssertFalse(MapFeatureOnboardingView().shouldLoad(), "Profile onboarding should not show if default is true")
    }
}

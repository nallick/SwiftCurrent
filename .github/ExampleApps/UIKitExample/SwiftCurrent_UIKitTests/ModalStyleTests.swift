//
//  ModalStyleTests.swift
//  WorkflowTests
//
//  Created by Tyler Thompson on 3/8/20.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import Foundation
import XCTest
import UIUTest

@testable import SwiftCurrent
import SwiftCurrent_UIKit

class ModalStyleTests: XCTestCase {
    override class func setUp() {
        print("!!!! \(Date().timeIntervalSince1970) - ModalStyleTests - class setup starting. Top view controller: \(String(describing: UIApplication.topViewController()))")
        waitUntil(UIApplication.topViewController() != nil)
        print("!!!! \(Date().timeIntervalSince1970) - ModalStyleTests - class setup ending. Top view controller: \(String(describing: UIApplication.topViewController()))")
    }

    override func setUp() {
        UIView.setAnimationsEnabled(false)
        UIViewController.initializeTestable()
    }

    override func tearDown() {
        UIViewController.flushPendingTestArtifacts()
        UIView.setAnimationsEnabled(true)
    }

    func testShowModalFullScreen() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.fullScreen)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .fullScreen)
    }

    func testShowModalAsPageSheet() {
        let vc = RootViewController()
        vc.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.pageSheet)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .pageSheet)
    }

    func testShowModalAsFormSheet() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.formSheet)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .formSheet)
    }

    func testShowModalWithCurrentContext() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.currentContext)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .currentContext)
    }

    func testShowModalAsCustom() {
        RootViewController.standard.loadForTesting()
        XCTAssertNotNil(UIApplication.topViewController(), "loadForTesting() failed to update the top view controller")

        UIApplication.topViewController()?.launchInto(Workflow(TestViewController.self,
                                               launchStyle: .modal(.custom)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle.rawValue, UIModalPresentationStyle.custom.rawValue)
    }

    func testShowModalOverFullScreen() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.overFullScreen)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .overFullScreen)
    }

    func testShowModalOverCurrentContext() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.overCurrentContext)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .overCurrentContext)
    }

    func testShowModalAsPopover() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.popover)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .popover)
    }

    @available(iOS 13.0, *)
    func testShowModalWithAutomaticStyle() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self,
                                 launchStyle: .modal(.automatic)))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, UIViewController().modalPresentationStyle)
    }

    func testShowModalFullScreen_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.fullScreen))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .fullScreen)
    }

    func testShowModalAsPageSheet_FromLaunch() {
        let vc = RootViewController()
        vc.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.pageSheet))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .pageSheet)
    }

    func testShowModalAsFormSheet_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.formSheet))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .formSheet)
    }

    func testShowModalWithCurrentContext_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.currentContext))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .currentContext)
    }

    func testShowModalAsCustom_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.custom))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .custom)
    }

    func testShowModalOverFullScreen_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.overFullScreen))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .overFullScreen)
    }

    func testShowModalOverCurrentContext_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.overCurrentContext))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .overCurrentContext)
    }

    func testShowModalAsPopover_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.popover))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .popover)
    }

    @available(iOS 13.0, *)
    func testShowModalWithAutomaticStyle_FromLaunch() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self),
                             withLaunchStyle: .modal(.automatic))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, UIViewController().modalPresentationStyle)
    }

    func testShowModalFullScreen_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.fullScreen))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .fullScreen)
    }

    func testShowModalAsPageSheet_FromLaunch_WithFirstScreenOnANavController() {
        let vc = RootViewController()
        vc.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.pageSheet))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.modalPresentationStyle, .pageSheet)
    }

    func testShowModalAsFormSheet_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.formSheet))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .formSheet)
    }

    func testShowModalWithCurrentContext_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.currentContext))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .currentContext)
    }

    func testShowModalAsCustom_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.custom))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .custom)
    }

    func testShowModalOverFullScreen_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.overFullScreen))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .overFullScreen)
    }

    func testShowModalOverCurrentContext_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.overCurrentContext))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .overCurrentContext)
    }

    func testShowModalAsPopover_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.popover))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, .popover)
    }

    @available(iOS 13.0, *)
    func testShowModalWithAutomaticStyle_FromLaunch_WithFirstScreenOnANavController() {
        RootViewController.standard.loadForTesting()

        UIApplication.topViewController()?
            .launchInto(Workflow(TestViewController.self, launchStyle: .navigationStack),
                             withLaunchStyle: .modal(.automatic))

        XCTAssertUIViewControllerDisplayed(ofType: TestViewController.self)
        XCTAssertEqual(UIApplication.topViewController()?.navigationController?.modalPresentationStyle, UIViewController().modalPresentationStyle)
    }
}

extension ModalStyleTests {
    class RootViewController: UIWorkflowItem<Never, Never>, FlowRepresentable {
        static var standard: ModalStyleTests.RootViewController {
            let controller = Self()
            controller.view.backgroundColor = .blue
            return controller
        }
    }

    class TestViewController: UIWorkflowItem<Never, Any?>, FlowRepresentable {
        var data: Any?
        func next() {
            proceedInWorkflow(data)
        }
    }
}

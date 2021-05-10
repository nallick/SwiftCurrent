//
//  UIKitPresenterTests.swift
//  WorkflowUIKitTests
//
//  Created by Tyler Thompson on 5/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import Foundation
import XCTest

@testable import Workflow
@testable import WorkflowUIKit

#warning("COME BACK TO THIS!!!")
class UIKitPresenterTests: XCTestCase {
    func testUnknownLaunchStyleThrowsFatalError() {
        let ls = LaunchStyle.new
        class FR1: TestViewController { }
        class FR2: TestViewController { }

        let wf = Workflow(FR1.self).thenPresent(FR2.self)
        let rootController = UIViewController()
        rootController.loadForTesting()

        let presenter = UIKitPresenter(rootController, launchStyle: .modal)

        wf.applyOrchestrationResponder(presenter)
        var fr1 = FR1(with: .none)
        let metadata = FlowRepresentableMetadata(FR1.self, launchStyle: ls, flowPersistence: { _ in .default })
        let node = AnyWorkflow.Element(with: WorkflowItem(metadata: metadata, instance: AnyFlowRepresentable(&fr1)))

        XCTAssertThrowsFatalError {
            presenter.proceed(to: node, from: node)
        }
    }

    func testEvenWithoutAResponder_WorkflowStillAbandons() {
        class FR1: TestViewController { }
        let wf = Workflow(FR1.self)
        wf.launch()

        wf.abandon()

        XCTAssertNil(wf.first?.value.instance?.proceedInWorkflowStorage)
        XCTAssertNil(wf.first?.value.instance)
    }
}

extension UIKitPresenterTests {
    class TestViewController: UIWorkflowItem<AnyWorkflow.PassedArgs, Any?>, FlowRepresentable {
        var data: Any?

        required init(with args: AnyWorkflow.PassedArgs) {
            super.init(nibName: nil, bundle: nil)
            view.backgroundColor = .red
            data = args.extractArgs(defaultValue: nil)
        }

        required init?(coder: NSCoder) { nil }

        func next() {
            proceedInWorkflow(data)
        }
    }
}

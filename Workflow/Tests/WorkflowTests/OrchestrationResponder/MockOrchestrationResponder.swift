//
//  MockOrchestrationResponder.swift
//  
//
//  Created by Tyler Thompson on 11/25/20.
//

import Foundation
import Workflow

class MockOrchestrationResponder: OrchestrationResponder {
    var launchCalled = 0
    var lastTo: AnyWorkflow.Element?
    func launch(to: AnyWorkflow.Element) {
        lastTo = to
        launchCalled += 1
    }

    var proceedCalled = 0
    var lastFrom: AnyWorkflow.Element?
    var lastCompletion:(() -> Void)?
    func proceed(to: AnyWorkflow.Element,
                 from: AnyWorkflow.Element) {
        lastTo = to
        lastFrom = from
        proceedCalled += 1
    }

    var backUpCalled = 0
    func backUp(from: AnyWorkflow.Element, to: AnyWorkflow.Element) {
        lastFrom = from
        lastTo = to
        backUpCalled += 1
    }

    var abandonCalled = 0
    var lastWorkflow: AnyWorkflow?
    var lastOnFinish:(() -> Void)?
    func abandon(_ workflow: AnyWorkflow, onFinish: (() -> Void)?) {
        lastWorkflow = workflow
        lastOnFinish = onFinish
        abandonCalled += 1
    }
}

//
//  OrchestrationResponderTests.swift
//  
//
//  Created by Tyler Thompson on 11/24/20.
//

import Foundation
import XCTest

import Workflow

class OrchestrationResponderTests : XCTestCase {
    func testWorkflowCanProceedForwardThroughFlow() {
        class FR1: TestPassthroughFlowRepresentable { }
        class FR2: TestPassthroughFlowRepresentable { }
        class FR3: TestPassthroughFlowRepresentable { }
        let wf = Workflow(FR1.self)
            .thenPresent(FR2.self)
            .thenPresent(FR3.self)
        let responder = MockOrchestrationResponder()
        wf.applyOrchestrationResponder(responder)
        
        let launchedRepresentable = wf.launch(with: nil)
        
        XCTAssertEqual(responder.launchCalled, 1)
        XCTAssert(launchedRepresentable?.value?.underlyingInstance is FR1)
        XCTAssert(responder.lastTo?.instance.value?.underlyingInstance is FR1)
        XCTAssertNil(responder.lastFrom)

        (launchedRepresentable?.value?.underlyingInstance as? FR1)?.proceedInWorkflow()
        
        XCTAssertEqual(responder.proceedCalled, 1)
        XCTAssert(responder.lastTo?.instance.value?.underlyingInstance is FR2)
        XCTAssertNotNil(responder.lastFrom)
        XCTAssert(responder.lastFrom?.instance.value?.underlyingInstance is FR1)
        XCTAssert((responder.lastFrom?.instance.value?.underlyingInstance as? FR1) === (launchedRepresentable?.value?.underlyingInstance as? FR1))

        let fr2 = (responder.lastTo?.instance.value?.underlyingInstance as? FR2)
        fr2?.proceedInWorkflow()
        
        XCTAssertEqual(responder.proceedCalled, 2)
        XCTAssert(responder.lastTo?.instance.value?.underlyingInstance is FR3)
        XCTAssertNotNil(responder.lastFrom)
        XCTAssert(responder.lastFrom?.instance.value?.underlyingInstance is FR2)
        XCTAssert((responder.lastFrom?.instance.value?.underlyingInstance as? FR2) === fr2)
    }
    
    func testWorkflowCallsOnFinishWhenItIsDone() {
        class FR1: TestPassthroughFlowRepresentable { }
        class FR2: TestPassthroughFlowRepresentable { }
        class FR3: TestPassthroughFlowRepresentable { }
        let wf = Workflow(FR1.self)
            .thenPresent(FR2.self)
            .thenPresent(FR3.self)
        let responder = MockOrchestrationResponder()
        wf.applyOrchestrationResponder(responder)
        let expectation = self.expectation(description: "OnFinish called")
        
        let launchedRepresentable = wf.launch(with: nil) { _ in expectation.fulfill() }
        
        (launchedRepresentable?.value?.underlyingInstance as? FR1)?.proceedInWorkflow()
        (responder.lastTo?.instance.value?.underlyingInstance as? FR2)?.proceedInWorkflow()
        (responder.lastTo?.instance.value?.underlyingInstance as? FR3)?.proceedInWorkflow()
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testWorkflowCallsOnFinishWhenItIsDone_andPassesForwardLastArguments() {
        class Object { }
        let val = Object()
        class FR1: TestPassthroughFlowRepresentable { }
        class FR2: TestPassthroughFlowRepresentable { }
        class FR3: TestFlowRepresentable<Never, Object>, FlowRepresentable { }
        let wf = Workflow(FR1.self)
            .thenPresent(FR2.self)
            .thenPresent(FR3.self)
        let responder = MockOrchestrationResponder()
        wf.applyOrchestrationResponder(responder)
        let expectation = self.expectation(description: "OnFinish called")
        
        let launchedRepresentable = wf.launch(with: nil) { args in
            XCTAssert(args as? Object === val)
            expectation.fulfill()
        }
        
        (launchedRepresentable?.value?.underlyingInstance as? FR1)?.proceedInWorkflow()
        (responder.lastTo?.instance.value?.underlyingInstance as? FR2)?.proceedInWorkflow()
        (responder.lastTo?.instance.value?.underlyingInstance as? FR3)?.proceedInWorkflow(val)
        
        wait(for: [expectation], timeout: 3)
    }
}

extension OrchestrationResponderTests {
    class TestFlowRepresentable<Input, Output> {
        weak var workflow: AnyWorkflow?
        
        var proceedInWorkflowStorage: ((Any?) -> Void)?

        required init() { }
        static func instance() -> Self { Self() }

        typealias WorkflowInput = Input
        typealias WorkflowOutput = Output
    }
    
    class TestPassthroughFlowRepresentable: FlowRepresentable {
        weak var workflow: AnyWorkflow?
        
        var proceedInWorkflowStorage: ((Any?) -> Void)?
        
        required init() { }
        
        static func instance() -> Self { Self() }
        
        typealias WorkflowInput = Never
        typealias WorkflowOutput = Never
    }
}

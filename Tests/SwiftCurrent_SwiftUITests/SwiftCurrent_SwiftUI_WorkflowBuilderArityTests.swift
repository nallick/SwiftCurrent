//
//  SwiftCurrent_SwiftUI_WorkflowBuilderArityTests.swift
//  SwiftCurrent
//
//  Created by Matt Freiburg on 2/21/22.
//  Copyright © 2022 WWT and Tyler Thompson. All rights reserved.
//  

import XCTest
import SwiftUI
import ViewInspector

import SwiftCurrent
@testable import SwiftCurrent_SwiftUI // testable sadly needed for inspection.inspect to work

@available(iOS 15.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class SwiftCurrent_SwiftUI_WorkflowBuilderArityTests: XCTestCase, App {
    func testArity1() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
    }

    func testArity2() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
    }

    func testArity3() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
    }

    func testArity3_WithBuildOptional() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                if true {
                    WorkflowItem(FR2.self)
                    WorkflowItem(FR3.self)
                }
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
    }

    func testArity3_WithBuildEither() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                if true {
                    WorkflowItem(FR2.self)
                    WorkflowItem(FR3.self)
                } else {
                    WorkflowItem(FR3.self)
                    WorkflowItem(FR2.self)
                }
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
    }

    func testArity4() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
    }

    func testArity5() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
    }

    func testArity6() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowItem(FR6.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
    }

    func testArity7() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowItem(FR6.self)
                WorkflowItem(FR7.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
        try await viewUnderTest.find(FR7.self).proceedInWorkflow()
    }

    func testArity8() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR8: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowItem(FR6.self)
                WorkflowItem(FR7.self)
                WorkflowItem(FR8.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
        try await viewUnderTest.find(FR7.self).proceedInWorkflow()
        try await viewUnderTest.find(FR8.self).proceedInWorkflow()
    }

    func testArity9() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR8: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }
        struct FR9: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR9 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowItem(FR6.self)
                WorkflowItem(FR7.self)
                WorkflowItem(FR8.self)
                WorkflowItem(FR9.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
        try await viewUnderTest.find(FR7.self).proceedInWorkflow()
        try await viewUnderTest.find(FR8.self).proceedInWorkflow()
        try await viewUnderTest.find(FR9.self).proceedInWorkflow()
    }

    func testArity10() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR8: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }
        struct FR9: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR9 type") }
        }
        struct FR10: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR10 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowItem(FR6.self)
                WorkflowItem(FR7.self)
                WorkflowItem(FR8.self)
                WorkflowItem(FR9.self)
                WorkflowItem(FR10.self)
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
        try await viewUnderTest.find(FR7.self).proceedInWorkflow()
        try await viewUnderTest.find(FR8.self).proceedInWorkflow()
        try await viewUnderTest.find(FR9.self).proceedInWorkflow()
        try await viewUnderTest.find(FR10.self).proceedInWorkflow()
    }

    func testArity5_WithWorkflowGroup() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR8: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }
        struct FR9: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR9 type") }
        }
        struct FR10: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR10 type") }
        }

        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowItem(FR2.self)
                WorkflowItem(FR3.self)
                WorkflowItem(FR4.self)
                WorkflowItem(FR5.self)
                WorkflowGroup {
                    WorkflowItem(FR6.self)
                    WorkflowItem(FR7.self)
                    WorkflowItem(FR8.self)
                    WorkflowItem(FR9.self)
                    WorkflowItem(FR10.self)
                }
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await viewUnderTest.find(FR1.self).proceedInWorkflow()
        try await viewUnderTest.find(FR2.self).proceedInWorkflow()
        try await viewUnderTest.find(FR3.self).proceedInWorkflow()
        try await viewUnderTest.find(FR4.self).proceedInWorkflow()
        try await viewUnderTest.find(FR5.self).proceedInWorkflow()
        try await viewUnderTest.find(FR6.self).proceedInWorkflow()
        try await viewUnderTest.find(FR7.self).proceedInWorkflow()
        try await viewUnderTest.find(FR8.self).proceedInWorkflow()
        try await viewUnderTest.find(FR9.self).proceedInWorkflow()
        try await viewUnderTest.find(FR10.self).proceedInWorkflow()
    }

    func testUltramassiveWorkflow() async throws {
        struct FR1: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR2: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR3: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR4: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR5: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR6: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR7: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR8: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }
        struct FR9: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR9 type") }
        }
        struct FR10: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR10 type") }
        }
        struct FR11: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR1 type") }
        }
        struct FR12: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR2 type") }
        }
        struct FR13: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR3 type") }
        }
        struct FR14: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR4 type") }
        }
        struct FR15: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR5 type") }
        }
        struct FR16: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR6 type") }
        }
        struct FR17: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR7 type") }
        }
        struct FR18: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR8 type") }
        }
        struct FR19: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR9 type") }
        }
        struct FR20: View, FlowRepresentable, Inspectable {
            var _workflowPointer: AnyFlowRepresentable?
            var body: some View { Text("FR10 type") }
        }
        
        let viewUnderTest = try await MainActor.run {
            WorkflowView {
                WorkflowItem(FR1.self)
                WorkflowGroup {
                    WorkflowItem(FR2.self)
                    WorkflowItem(FR3.self)
                    WorkflowItem(FR4.self)
                    WorkflowItem(FR5.self)
                    WorkflowItem(FR6.self)
                    WorkflowItem(FR7.self)
                    WorkflowItem(FR8.self)
                    WorkflowItem(FR9.self)
                    WorkflowGroup {
                        WorkflowItem(FR10.self)
                        WorkflowItem(FR11.self)
                        WorkflowItem(FR12.self)
                        WorkflowItem(FR13.self)
                        WorkflowItem(FR14.self)
                        WorkflowItem(FR15.self)
                        WorkflowItem(FR16.self)
                        WorkflowItem(FR17.self)
                        WorkflowItem(FR18.self)
                        WorkflowGroup {
                            WorkflowItem(FR19.self)
                            WorkflowItem(FR20.self)
                        }
                    }
                }
            }
        }.hostAndInspect(with: \.inspection).extractWorkflowLauncher().extractWorkflowItemWrapper()

        try await MainActor.run {
            try viewUnderTest.find(FR1.self).actualView().proceedInWorkflow()
            try viewUnderTest.find(ViewType.View<FR2>.self, traversal: .depthFirst).actualView().proceedInWorkflow()
            try viewUnderTest.find(ViewType.View<FR3>.self, traversal: .depthFirst).actualView().proceedInWorkflow()
        }
    }
}

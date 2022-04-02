//
//  TestView.swift
//  SwiftUIExample
//
//  Created by Richard Gist on 9/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent_SwiftUI

struct TestView: View {
    var body: some View {
        switch Environment.viewToTest {
            case .oneItemWorkflow: oneItemWorkflow
            case .twoItemWorkflow: twoItemWorkflow
            case .threeItemWorkflow: threeItemWorkflow
            case .fourItemWorkflow: fourItemWorkflow
            default: EmptyView()
        }
    }

    @ViewBuilder var oneItemWorkflow: some View {
        if Environment.shouldEmbedInNavStack {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
            }.embedInNavigationView()
        } else {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
            }
        }
    }

    @ViewBuilder var twoItemWorkflow: some View {
        if Environment.shouldEmbedInNavStack {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
            }.embedInNavigationView()
        } else {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
            }
        }
    }

    @ViewBuilder var threeItemWorkflow: some View {
        if Environment.shouldEmbedInNavStack {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
                WorkflowItem(FR3.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
            }.embedInNavigationView()
        } else {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
                WorkflowItem(FR3.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
            }
        }
    }

    @ViewBuilder var fourItemWorkflow: some View {
        if Environment.shouldEmbedInNavStack {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
                WorkflowItem(FR3.self)
                    .persistence(persistence(for: FR3.self))
                    .presentationType(presentationType(for: FR3.self))
                WorkflowItem(FR4.self)
                    .persistence(persistence(for: FR4.self))
                    .presentationType(presentationType(for: FR4.self))
            }.embedInNavigationView()
        } else {
            WorkflowView {
                WorkflowItem(FR1.self)
                    .persistence(persistence(for: FR1.self))
                    .presentationType(presentationType(for: FR1.self))
                WorkflowItem(FR2.self)
                    .persistence(persistence(for: FR2.self))
                    .presentationType(presentationType(for: FR2.self))
                WorkflowItem(FR3.self)
                    .persistence(persistence(for: FR3.self))
                    .presentationType(presentationType(for: FR3.self))
                WorkflowItem(FR4.self)
                    .persistence(persistence(for: FR4.self))
                    .presentationType(presentationType(for: FR4.self))
            }
        }
    }

    func persistence<F>(for type: F.Type) -> FlowPersistence.SwiftUI.Persistence {
        if case .persistence(_, let persistence) = Environment.persistence(for: type),
           let enumValue = FlowPersistence.SwiftUI.Persistence(rawValue: persistence) {
            return enumValue
        }
        return .default
    }

    func presentationType<F>(for type: F.Type) -> LaunchStyle.SwiftUI.PresentationType {
        if case .presentationType(_, let presentationType) = Environment.presentationType(for: type) {
            return presentationType
        }
        return .default
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

import SwiftCurrent
struct FR1: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
            Button("Navigate backward") { try? backUpInWorkflow() }
        }
    }

    func shouldLoad() -> Bool {
        guard case .shouldLoad(_, let shouldLoad) = Environment.shouldLoad(for: Self.self) else { return true }
        return shouldLoad
    }
}

struct FR2: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
            Button("Navigate backward") { try? backUpInWorkflow() }
        }
    }

    func shouldLoad() -> Bool {
        guard case .shouldLoad(_, let shouldLoad) = Environment.shouldLoad(for: Self.self) else { return true }
        return shouldLoad
    }
}

struct FR3: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
            Button("Navigate backward") { try? backUpInWorkflow() }
        }
    }

    func shouldLoad() -> Bool {
        guard case .shouldLoad(_, let shouldLoad) = Environment.shouldLoad(for: Self.self) else { return true }
        return shouldLoad
    }
}

struct FR4: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
            Button("Navigate backward") { try? backUpInWorkflow() }
        }
    }

    func shouldLoad() -> Bool {
        guard case .shouldLoad(_, let shouldLoad) = Environment.shouldLoad(for: Self.self) else { return true }
        return shouldLoad
    }
}

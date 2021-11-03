//  swiftlint:disable:this file_name
//  WorkflowExtensions.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 7/13/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftCurrent
import SwiftUI

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
extension Workflow where F: FlowRepresentable & View {
    /**
     Creates a `Workflow` with a `FlowRepresentable`.
     - Parameter type: a reference to the first `FlowRepresentable`'s concrete type in the workflow.
     - Parameter launchStyle: the `LaunchStyle` the `FlowRepresentable` should use while it's part of this workflow.
     - Parameter flowPersistence: a `FlowPersistence` representing how this item in the workflow should persist.
     */
    public convenience init(_ type: F.Type,
                            launchStyle: LaunchStyle = .default,
                            flowPersistence: @escaping @autoclosure () -> FlowPersistence = .default) {
        self.init(ExtendedFlowRepresentableMetadata(flowRepresentableType: type,
                                                    launchStyle: launchStyle) { _ in flowPersistence() })
    }

    /// Called when the workflow should be terminated, and the app should return to the point before the workflow was launched.
    public func abandon() {
        AnyWorkflow(self).abandon()
    }

    /**
     Adds an item to the workflow; enforces the `FlowRepresentable.WorkflowOutput` of the previous item matches the `FlowRepresentable.WorkflowInput` of this item.
     - Parameter type: a reference to the next `FlowRepresentable`'s concrete type in the workflow.
     - Parameter launchStyle: the `LaunchStyle` the `FlowRepresentable` should use while it's part of this workflow.
     - Parameter flowPersistence: a closure returning a `FlowPersistence` representing how this item in the workflow should persist.
     - Returns: a new workflow with the additional `FlowRepresentable` item.
     */
    public func thenProceed<F: FlowRepresentable & View>(with type: F.Type,
                                                         launchStyle: LaunchStyle = .default,
                                                         flowPersistence: @escaping (F.WorkflowInput) -> FlowPersistence) -> Workflow<F> where F.WorkflowInput == AnyWorkflow.PassedArgs {
        let workflow = Workflow<F>(first)
        workflow.append(ExtendedFlowRepresentableMetadata(flowRepresentableType: type,
                                                          launchStyle: launchStyle) { flowPersistence($0) })
        return workflow
    }

    /**
     Adds an item to the workflow; enforces the `FlowRepresentable.WorkflowOutput` of the previous item matches the `FlowRepresentable.WorkflowInput` of this item.
     - Parameter type: a reference to the next `FlowRepresentable`'s concrete type in the workflow.
     - Parameter launchStyle: the `LaunchStyle` the `FlowRepresentable` should use while it's part of this workflow.
     - Parameter flowPersistence: a closure returning a `FlowPersistence` representing how this item in the workflow should persist.
     - Returns: a new workflow with the additional `FlowRepresentable` item.
     */
    public func thenProceed<F: FlowRepresentable & View>(with type: F.Type,
                                                         launchStyle: LaunchStyle = .default,
                                                         flowPersistence: @escaping () -> FlowPersistence) -> Workflow<F> where F.WorkflowInput == Never {
        let workflow = Workflow<F>(first)
        workflow.append(ExtendedFlowRepresentableMetadata(flowRepresentableType: type,
                                                          launchStyle: launchStyle) { _ in flowPersistence() })
        return workflow
    }
}

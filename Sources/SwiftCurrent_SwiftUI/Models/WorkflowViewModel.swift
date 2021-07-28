//
//  WorkflowViewModel.swift
//  SwiftCurrent_SwiftUI
//
//  Created by Megan Wiemer on 7/13/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftCurrent
import SwiftUI
import Combine

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class WorkflowViewModel: ObservableObject {
    @Published var body: Any?
    let onAbandonPublisher = PassthroughSubject<Void, Never>()
    let onFinishPublisher = CurrentValueSubject<AnyWorkflow.PassedArgs?, Never>(nil)

    var isLaunched: Binding<Bool>?
    private let launchArgs: AnyWorkflow.PassedArgs

    init(isLaunched: Binding<Bool>, launchArgs: AnyWorkflow.PassedArgs) {
        self.isLaunched = isLaunched
        self.launchArgs = launchArgs
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
extension WorkflowViewModel: OrchestrationResponder {
    func launch(to destination: AnyWorkflow.Element) {
        body = extractView(from: destination).erasedView
    }

    func proceed(to destination: AnyWorkflow.Element, from source: AnyWorkflow.Element) {
        body = extractView(from: destination).erasedView
    }

    func backUp(from source: AnyWorkflow.Element, to destination: AnyWorkflow.Element) {
        body = extractView(from: destination).erasedView
    }

    func abandon(_ workflow: AnyWorkflow, onFinish: (() -> Void)?) {
        isLaunched?.wrappedValue = false
        body = nil
        onAbandonPublisher.send()
        if isLaunched?.wrappedValue == true {
            workflow.launch(withOrchestrationResponder: self, passedArgs: launchArgs)
        }
    }

    func complete(_ workflow: AnyWorkflow, passedArgs: AnyWorkflow.PassedArgs, onFinish: ((AnyWorkflow.PassedArgs) -> Void)?) {
        if workflow.lastLoadedItem?.value.metadata.persistence == .removedAfterProceeding {
            if let lastPresentableItem = workflow.lastPresentableItem {
                body = extractView(from: lastPresentableItem).erasedView
            } else {
                isLaunched?.wrappedValue = false
            }
        }
        onFinishPublisher.send(passedArgs)
        onFinish?(passedArgs)
    }

    private func extractView(from element: AnyWorkflow.Element) -> AnyFlowRepresentableView {
        guard let instance = element.value.instance as? AnyFlowRepresentableView else {
            fatalError("Could not cast \(String(describing: element.value.instance)) to expected type: AnyFlowRepresentableView")
        }
        return instance
    }
}

extension AnyWorkflow {
    fileprivate var lastLoadedItem: AnyWorkflow.Element? {
        last { $0.value.instance != nil }
    }

    fileprivate var lastPresentableItem: AnyWorkflow.Element? {
        last {
            $0.value.instance != nil && $0.value.metadata.persistence != .removedAfterProceeding
        }
    }
}

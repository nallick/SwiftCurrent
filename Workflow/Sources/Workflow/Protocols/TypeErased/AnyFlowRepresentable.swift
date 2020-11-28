//
//  AnyFlowRepresentable.swift
//  Workflow
//
//  Created by Tyler Thompson on 8/25/19.
//  Copyright © 2019 Tyler Tompson. All rights reserved.
//

import Foundation

class AnyFlowRepresentableStorageBase {
    var underlyingInstance: Any { fatalError() }
    var workflow: AnyWorkflow?
    var proceedInWorkflowStorage: ((Any?) -> Void)?
    func shouldLoad(with args: Any?) -> Bool { fatalError() }
}

class AnyFlowRepresentableStorage<FR: FlowRepresentable>: AnyFlowRepresentableStorageBase {
    var holder: FR

    override var workflow: AnyWorkflow? {
        get {
            holder.workflow
        }
        set {
            holder.workflow = newValue
        }
    }

    override var proceedInWorkflowStorage: ((Any?) -> Void)? {
        get {
            holder.proceedInWorkflowStorage
        }
        set {
            holder.proceedInWorkflowStorage = newValue
        }
    }

    override func shouldLoad(with args: Any?) -> Bool {
        switch args {
            case _ where FR.WorkflowInput.self == Never.self: return holder.shouldLoad()
            default:
                guard let cast = args as? FR.WorkflowInput else { fatalError("TYPE MISMATCH: \(String(describing: args)) is not type: \(FR.WorkflowInput.self)") }
                return holder.shouldLoad(with: cast)

        }
    }

    override var underlyingInstance: Any {
        return holder
    }

    init(_ instance: inout FR) {
        holder = instance
    }
}

public class AnyFlowRepresentable {
    func shouldLoad(with args: Any?) -> Bool { _storage.shouldLoad(with: args) }

    typealias WorkflowInput = Any
    typealias WorkflowOutput = Any

    var workflow: AnyWorkflow? {
        get {
            _storage.workflow
        } set {
            _storage.workflow = newValue
        }
    }

    var proceedInWorkflowStorage: ((Any?) -> Void)? {
        get {
            _storage.proceedInWorkflowStorage
        } set {
            _storage.proceedInWorkflowStorage = newValue
        }
    }

    var _storage: AnyFlowRepresentableStorageBase

    public var underlyingInstance: Any {
        _storage.underlyingInstance
    }

    init<FR: FlowRepresentable>(_ instance: FR) {
        var instance = instance
        _storage = AnyFlowRepresentableStorage(&instance)
    }
}

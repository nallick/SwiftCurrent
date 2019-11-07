//
//  UIKitPresenter.swift
//  Workflow
//
//  Created by Tyler Thompson on 8/26/19.
//  Copyright © 2019 Tyler Tompson. All rights reserved.
//

import Foundation
import UIKit

open class UIKitPresenter: BasePresenter<UIViewController>, Presenter {
    public func destroy(_ view: UIViewController) {
        if let nav = view.navigationController {
            let vcs = nav.viewControllers.filter {
                return $0 !== view
            }
            nav.setViewControllers(vcs, animated: false)
        }
    }
    
    public func launch(view: UIViewController, from root: UIViewController, withLaunchStyle launchStyle:PresentationType = .default, animated:Bool) {
        switch launchStyle {
            case .default:
                if let style = (view as? AnyFlowRepresentable)?.preferredLaunchStyle,
                    style == .modally {
                    root.present(view, animated: animated)
                } else if let nav = root.navigationController
                    ?? root as? UINavigationController {
                    nav.pushViewController(view, animated: animated)
                } else {
                    root.present(view, animated: animated)
                }
            case .modally:
                if let style = (view as? AnyFlowRepresentable)?.preferredLaunchStyle,
                    style == .navigationStack {
                    let nav = UINavigationController(rootViewController: view)
                    root.present(nav, animated: animated)
                } else {
                    root.present(view, animated: animated)
                }
            case .navigationStack:
                if let nav = root.navigationController
                    ?? root as? UINavigationController {
                    nav.pushViewController(view, animated: animated)
                } else {
                    let nav = UINavigationController(rootViewController: view)
                    root.present(nav, animated: animated)
                }
        }
    }
    
    public func abandon(_ workflow:Workflow, animated:Bool = true, onFinish:(() -> Void)? = nil) {
        guard let first = workflow.firstLoadedInstance?.value as? UIViewController else { return }
        if let nav = first.navigationController {
            if nav.viewControllers.first === first {
                if let presenting = nav.presentingViewController {
                    presenting.dismiss(animated: animated, completion: onFinish)
                }
            } else {
                if let _ = nav.presentedViewController {
                    nav.dismiss(animated: animated) {
                        onFinish?()
                        nav.popToViewController(first, animated: false)
                        nav.popViewController(animated: animated)
                    }
                } else {
                    onFinish?()
                    nav.popToViewController(first, animated: false)
                    nav.popViewController(animated: animated)
                }
            }
        } else {
            first.dismiss(animated: animated, completion: onFinish)
        }
    }
}

public extension UIViewController {
    ///launchInto: When using UIKit this is how you launch a workflow
    /// - Parameter workflow: `Workflow` to launch
    /// - Parameter args: Args to pass to the first `FlowRepresentable`
    /// - Parameter launchStyle: The `PresentationType` used to launch the workflow
    /// - Parameter onFinish: A callback that is called when the last item in the workflow calls back
    /// - Note: In the background this applies a UIKitPresenter, if you call launch on workflow directly you'll need to apply one yourself
    func launchInto(_ workflow:Workflow, args:Any? = nil, withLaunchStyle launchStyle:PresentationType = .default, onFinish:((Any?) -> Void)? = nil) {
        workflow.applyPresenter(UIKitPresenter())
        _ = workflow.launch(from: self, with: args, withLaunchStyle: launchStyle, onFinish: onFinish)?.value as? UIViewController
    }
}

public extension FlowRepresentable where Self: UIViewController {
    func abandonWorkflow() {
        workflow?.abandon()
    }
}

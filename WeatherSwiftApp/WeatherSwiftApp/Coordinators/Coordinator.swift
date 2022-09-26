//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit

// MARK: - Protocols
protocol Coordinator: AnyObject {
    // MARK: - Internal Properties
    /// Child coordinators.
    var childCoordinators: [Coordinator] { get set }
    /// Current navigation controller.
    var navigationController: UINavigationController? { get set }
    /// Parrent coordinator.
    var parentCoordinator: Coordinator? { get set }

    // MARK: - Internal Funcs
    /// Common method to start the current coordinator.
    func start()
}

// MARK: - Helpers
extension Coordinator {
    /// Back to previous view controller.
    ///
    /// - Parameters:
    ///     - animated: coordinator animation state
    func back(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }

    /// Dismisses current view controller.
    ///
    /// - Parameters:
    ///     - animated: coordinator animation state
    ///     - completion: optionnal callback after a dismiss
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        self.navigationController?.dismiss(animated: animated, completion: completion)
    }

    /// Push new view controller.
    ///
    /// - Parameters:
    ///     - viewController: the view controller to push
    ///     - animated: coordinator animation state
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(viewController, animated: animated)
    }

    /// Presents new view controller.
    ///
    /// - Parameters:
    ///     - viewController: the view controller to present
    ///     - animated: coordinator animation state
    ///     - completion: optionnal callback after a present
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.navigationController?.present(viewController, animated: animated, completion: completion)
    }
}

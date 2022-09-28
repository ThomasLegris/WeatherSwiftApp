//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit

/// Utility extension for `UIViewController`.
extension UIViewController {
    /// Show Alert with title, message and one button.
    ///
    /// - Parameters:
    ///   - title: The title of the Alert.
    ///   - message: The body of the Alert.
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.commonOk,
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }

    /// Sets up view controller tab bar.
    ///
    /// - Parameters:
    ///     - title: tab bar title
    ///     - image: tab bar image
    ///     - selectedImage: tab bar selected image
    func setupTabBar(title: String,
                     image: UIImage,
                     selectedImage: UIImage) {
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray],
                                          for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black],
                                          for: .selected)
        tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        self.tabBarItem = tabBarItem
    }
}

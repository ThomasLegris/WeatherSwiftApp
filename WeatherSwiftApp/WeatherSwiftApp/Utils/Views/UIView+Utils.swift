//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit

/// Utility extension for `UIView`.
extension UIView {
    /// Apply Corner radius to view with specific colors for border and background.
    ///
    /// - Parameters:
    ///    - backgroundColor: The background color
    ///    - borderColor: The border color
    ///    - radius: The angle radius
    ///    - borderWidth: The border width
    func cornerRadiusedWith(backgroundColor: ColorName,
                            borderColor: UIColor = .clear,
                            radius: CGFloat = 0.0,
                            borderWidth: CGFloat = 0.0) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor.color
    }

    /// Apply rounded corner radius with specific attributes.
    ///
    /// - Parameters:
    ///    - backgroundColor: Background color
    ///    - borderColor: The border color
    ///    - borderWidth: Width of the border
    func roundCorneredWith(backgroundColor: UIColor,
                           borderColor: UIColor = .clear,
                           borderWidth: CGFloat = 0.0) {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor
    }
}

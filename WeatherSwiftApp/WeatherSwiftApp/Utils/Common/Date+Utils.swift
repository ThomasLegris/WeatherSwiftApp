//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import Foundation

/// Utility extension for `Date`.
extension Date {
    /// Returns formatted date.
    ///
    /// - Parameters:
    ///     - format: selected format
    func formattedDate(with format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format

        return dateformat.string(from: self)
    }
}

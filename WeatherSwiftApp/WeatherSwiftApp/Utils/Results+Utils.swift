//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import RealmSwift

/// Utility extension for `Results`.
extension Results {
    /// Returns the result as Array of elements.
    var elements: [Element] {
        return compactMap {
            $0
        }
    }
}

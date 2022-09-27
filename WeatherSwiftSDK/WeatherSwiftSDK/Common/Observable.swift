//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 26/09/2022.
//

import Foundation

/// Custom class to handle data binding. Often used in viewmodel.
public class Observable<T> {
    // MARK: - Public Properties
    /// Our closure
    public var listener: ((T) -> Void)?

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    // MARK: - Init
    public init(value: T) {
        self.value = value
    }

    /// Data binding method to listen changement of value on T object.
    public func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}

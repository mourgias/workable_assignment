//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

extension Publisher {
    
    func done(receive: @escaping ((Self.Output) -> Void), catchError: ((Error) -> Void)? = nil) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            if let error = completion.error() {
                catchError?(error)
            }
        }, receiveValue: receive)
    }
}

extension Subscribers.Completion {
    
    func error() -> Failure? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
}

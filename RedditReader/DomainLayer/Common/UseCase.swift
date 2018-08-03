//
//  UseCase.swift
//  DomainLayer
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

open class UseCase<Input, Output> {

    func build(with args: Input, onError: @escaping (Error) -> Void, onSuccess: @escaping (Output) -> Void) {
        preconditionFailure("Must be overridden!")
    }

    public func execute(with args: Input, onError: ((Error) -> Void)?, onSuccess: ((Output) -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.build(with: args, onError: { (error) in
                DispatchQueue.main.async {
                    onError?(error)
                }
            }, onSuccess: { (output) in
                DispatchQueue.main.async {
                    onSuccess?(output)
                }
            })
        }
    }
}

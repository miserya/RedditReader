//
//  RequestProtocol.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var params: [String: Any]? { get }
}

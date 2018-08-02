//
//  NetworkingManager.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    static var `default`: NetworkingManager = NetworkingManager()
    
    private lazy var configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.allowsCellularAccess = true
        return config
    }()
    private lazy var session = URLSession(configuration: self.configuration)
    private var dataTasks = [String: URLSessionDataTask]()
    
    func request<Output: Decodable>(_ target: RequestTarget, completion: @escaping (Error?, Output?) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(target.baseURL)\(target.route.path)") else {
            completion(DomainLayerError.invalidRequest, nil)
            return
        }
        urlComponents.queryItems = target.params?.map({ (arg) -> URLQueryItem in
            return URLQueryItem(name: arg.key, value: String(describing: arg.value))
        })
        
        guard let url = urlComponents.url else {
            completion(DomainLayerError.invalidRequest, nil)
            return
        }
        
        if let dataTask = self.dataTasks[url.absoluteString] {
            dataTask.cancel()
            self.dataTasks[url.absoluteString] = nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.route.method
        
        debugPrint("REQUEST: \(urlRequest)")
        
        let dataTask = self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            
            defer { self.dataTasks[url.absoluteString] = nil }
            
            if let response = response {
                debugPrint("RESPONSE: \(response)")
            }
            
            if let error = error {
                completion(error, nil)
            }
            else if let data = data {
                do {
                    let output = try JSONDecoder().decode(Output.self, from: data)
                    completion(nil, output)
                }
                catch {
                    completion(error, nil)
                }
            }
        }
        
        dataTask.resume()
    }
}

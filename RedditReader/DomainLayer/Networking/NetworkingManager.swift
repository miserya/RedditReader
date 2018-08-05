//
//  NetworkingManager.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class NetworkingManager: NSObject, URLSessionDownloadDelegate {
    
    static var `default`: NetworkingManager = NetworkingManager()
    
    private lazy var dataSession: URLSession = { return URLSession(configuration: .default) }()
    private var dataTasks = [String: URLSessionDataTask]()
    
    private lazy var downloadsSession: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "RedditReaderDownloadSession"), delegate: self, delegateQueue: nil)
    }()
    private var downloadTasks = [String: DownloadTask]()

    deinit {
        self.dataSession.invalidateAndCancel()
        self.downloadsSession.invalidateAndCancel()
    }

    //MARK: - Data Request
    
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
        
        let dataTask = self.dataSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            
            defer { self.dataTasks[url.absoluteString] = nil }
            
//            if let response = response {
//                debugPrint("RESPONSE: \(response)")
//            }

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
        self.dataTasks[url.absoluteString] = dataTask
    }
    
    func requestDownload(with url: URL, completion: @escaping (Error?, URL?) -> Void) {
        if let dataTask = self.downloadTasks[url.absoluteString] {
            dataTask.task.cancel()
            self.downloadTasks[url.absoluteString] = nil
        }

        debugPrint(url)
        let fileName = url.lastPathComponent
        if let localUrl = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName), let _ = UIImage(contentsOfFile: localUrl.path) {
            completion(nil, localUrl)
        }
        else {
            let downloadTask = self.downloadsSession.downloadTask(with: url)
            downloadTask.resume()
            self.downloadTasks[url.absoluteString] = DownloadTask(task: downloadTask, completion: completion)
        }
    }
    
    func cancelDownloadingTask(with url: URL) {
        if let dataTask = self.downloadTasks[url.absoluteString] {
            dataTask.task.cancel()
            self.downloadTasks[url.absoluteString] = nil
        }
    }
    
    //MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.currentRequest?.url else { return }
        let downloadTaskInfo = self.downloadTasks[url.absoluteString]

        let fileName = url.lastPathComponent
        guard let localUrl = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) else {
            downloadTaskInfo?.completion(DomainLayerError.emptyResponse, nil)
            return
        }

        do {
            try FileManager.default.copyItem(at: location, to: localUrl)
            downloadTaskInfo?.completion(nil, location)

            self.downloadTasks[url.absoluteString] = nil
        }
        catch {
            downloadTaskInfo?.completion(error, nil)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let url = task.currentRequest?.url else { return }
        let downloadTaskInfo = self.downloadTasks[url.absoluteString]
        
        downloadTaskInfo?.completion(error, nil)
        
        self.downloadTasks[url.absoluteString] = nil
    }
    
}

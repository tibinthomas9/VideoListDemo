//
//  dataFetcher.swift
//  dataFetcher
//
//  Created by Tibin Thomas on 15/05/19.
//  Copyright © 2019 tibin. All rights reserved.
//

import Foundation


public protocol DataFetcher: class {
    associatedtype Model
    func fetch(_ url: URL,withCompletion completion: @escaping (Model?) -> Void)
    func decode(_ data: Data) -> Model?
    var isCancelled : Bool {get set}
    func cancelFetch()
    
}

extension DataFetcher {
    public func fetch(_ url: URL, withCompletion completion: @escaping (Model?) -> Void) {
        DataTaskManager.shared.dataTask(with: url) { (data, response, error) in
            guard self.isCancelled == false else{
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self.decode(data))
        }
        
    }
    public func cancelFetch(){
     self.isCancelled = true
    }
    
}

public class ImageRequest {
    let url: URL
    public var isCancelled: Bool = false
    public init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: DataFetcher {
    
    
    public func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
  public  func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        fetch(url, withCompletion: completion)
    }
}

public class JsonRequest<Model:Codable> {
    let url: URL
    public var isCancelled: Bool = false
    public init(url: URL) {
        self.url = url
    }
}

extension JsonRequest: DataFetcher {
    public func decode(_ data: Data) -> Model? {
        let  responeModel = try? JSONDecoder().decode(Model.self, from: data)
        return responeModel
    }
    
    public func load(withCompletion completion: @escaping (Model?) -> Void) {
        fetch(url, withCompletion: completion)
    }
}

class DataTaskManager {
    static let shared = DataTaskManager()
    let session = URLSession(configuration: .default)
    lazy var dataCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 10
        return cache
    }()
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    var tasks = [URL: [completionHandler]]()
    
    func dataTask(with url: URL, completion: @escaping completionHandler) {
        if let cachedVersion = dataCache.object(forKey:NSURL(string: url.absoluteString) ?? NSURL()) {
            // use the cached version
            completion(cachedVersion as? Data, nil, nil)
        } else {
            if tasks.keys.contains(url) {
                tasks[url]?.append(completion)
            } else {
                tasks[url] = [completion]
                let _ = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                    DispatchQueue.main.async {
                        self?.dataCache.setObject(data as AnyObject, forKey: url as AnyObject)
                        guard let completionHandlers = self?.tasks[url] else { return }
                        for handler in completionHandlers {
                            handler(data, response, error)
                        }
                    }
                }).resume()
            }
        }
    }
}

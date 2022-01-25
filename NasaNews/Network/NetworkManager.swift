//
//  NetworkManager.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation
import UIKit

class NetworkManager: NSObject {

    static private var imageQueue = OperationQueue()
    static private var imageCache = NSCache<AnyObject, AnyObject>()

    class func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let documentURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationURL = documentURL?.appendingPathComponent(url.lastPathComponent)

        if let fileURL = destinationURL, FileManager().fileExists(atPath: fileURL.path) {
            do {
                let jsonData = try Data(String(contentsOf: fileURL).utf8)
                let data = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(data))
            } catch {
                completion(.failure(APIError.unrecognized))
            }
        } else {
            do {
                let jsonData = try Data(String(contentsOf: url).utf8)
                let data = try JSONDecoder().decode(T.self, from: jsonData)
                self.saveFile(content: jsonData, destinationURL: destinationURL)
                completion(.success(data))
            } catch {
                completion(.failure(APIError.unrecognized))
            }
        }
    }

    static func saveFile(content: Data, destinationURL: URL?) {
        guard let url = destinationURL else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            do {
                try content.write(to: url)
            } catch {
                print("Save json to file: failed.")
            }
        }
    }

    class func fetch(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        if let cacheImage = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            // image alreay in cache
            completion(cacheImage)
        } else {
            // to download & add to cache
            guard let url = URL(string: imageUrl) else {
                return
            }
            let blockDownload = BlockOperation()
            blockDownload.addExecutionBlock {
                do {
                    let data = try Data(contentsOf: url)
                    guard let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    self.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                    self.mainQueue {
                        completion(image)
                    }
                } catch {
                    completion(nil)
                }
            }
            self.imageQueue.addOperation(blockDownload)
        }
    }
}

private extension NetworkManager {
    static func mainQueue(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            OperationQueue.main.addOperation {
                block()
            }
        }
    }
}

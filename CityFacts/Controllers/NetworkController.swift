//
//  NetworkController.swift
//  CityFacts
//
//  Created by Tai Chin Huang on 2021/9/14.
//

import UIKit

class NetworkController {
    static let shared = NetworkController()
    
    func fetchCountryData(completionHandler: @escaping ([Country]?) -> ()) {
        guard let  url = URL(string: "https://restcountries.eu/rest/v2/all") else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let searchResponse = try decoder.decode([Country].self, from: data)
                    completionHandler(searchResponse)
                } catch {
                    completionHandler(nil)
                }
            }
        }.resume()
    }
    
    let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        // Returns the value associated with a given key, 會return object(image)
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                // Sets the value of the specified key in the cache, 將抓到的圖存入cache裡(object:, forkey:)
                self.imageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
}

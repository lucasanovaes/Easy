//
//  EasyAPI.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation

final class EasyAPI{
    
    func fetchData(in url: String, parameters: [String: String], onComplete: @escaping (_ json: [String : AnyObject]?, _ error: Error?) -> Void){
        
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let requestUrl = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            if(error != nil){
                onComplete(nil, error)
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    print(json)
                    onComplete(json, nil)
                    
                }catch let error as NSError{
                    onComplete(nil, nil)
                    print("Error parsing json: \(error)")
                }
            }
        }).resume()
    }
    
}


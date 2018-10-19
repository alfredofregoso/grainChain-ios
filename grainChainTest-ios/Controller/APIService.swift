//
//  APIService.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/19/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import Foundation
import Alamofire

struct  APIService {
    
    func signIn(userName: String, password: String, success: @escaping () -> ()) {
        let url = URL(string: "https://kdmldkvxoe.execute-api.us-west-2.amazonaws.com/test")
        let user = "harvx_190878"
        let password = "supersecretpassword"
        let headers =  ["Content-Type": "application/json"]
        let parameters = ["username": user,
                          "password": password]
        guard let urlFinal = url else { return }
        Alamofire.request(urlFinal, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    if let body = json["body"] as? [String:Any]{
                        if let auth = body["auth"] as? [String:Any] {
                            if let user = auth["user"] as? [String:Any] {
                                print(user["name"] as? String ?? "")
                                UserDefaults.standard.set(user["name"] as? String, forKey: "userName")
                                success()
                            }
                        }
                    }
                }
                
                
            case .failure(_): break
                
            }
        }
    }
}

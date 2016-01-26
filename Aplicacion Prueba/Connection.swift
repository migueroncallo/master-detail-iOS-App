//
//  Connection.swift
//  Aplicacion Prueba
//
//  Created by Miguel Roncallo on 1/25/16.
//  Copyright © 2016 Miguel Roncallo. All rights reserved.
//

import Foundation

class Connection {
    var data = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    let connectionOKKey = "connectionok"
    
    func connect(){
        do {
            let opt = try HTTP.GET("https://api.myjson.com/bins/54tf5")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    self.defaults.setBool(true, forKey: self.connectionOKKey)

                    return //also notify app of failure as needed
                }
//                print("opt finished: \(response.text!)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.data = response.text!
                self.defaults.setBool(true, forKey: self.connectionOKKey)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
            self.defaults.setBool(true, forKey: self.connectionOKKey)

        }
    }
}
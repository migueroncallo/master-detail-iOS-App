//
//  Mensaje.swift
//  Aplicacion Prueba
//
//  Created by Miguel Roncallo on 1/25/16.
//  Copyright © 2016 Miguel Roncallo. All rights reserved.
//

import Foundation

class Mensaje {
    struct mensaje: JSONJoy{
        var title: String?
        var unread: Bool?
        var message: String?
    
    
        init(){}
    
        init(_ decoder:JSONDecoder){
            
            title = decoder["title"].string
            unread = decoder["unread"].bool
            message = decoder["message"].string
        
        }
    }
    
    struct message {
        var messages: Array<mensaje>? = []
        
        init(){}
        
        init(_ decoder:JSONDecoder){
            
            if let mensajes = decoder.array{
                
                for mensje in mensajes{
                    messages!.append(mensaje(mensje))
                }
            }
        }
    }
}

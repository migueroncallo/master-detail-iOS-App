//
//  DetailViewController.swift
//  Aplicacion Prueba
//
//  Created by Miguel Roncallo on 1/25/16.
//  Copyright © 2016 Miguel Roncallo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    
    @IBOutlet weak var messageTextView: UITextView!
    let defaults = NSUserDefaults.standardUserDefaults()
    let selectedmessage = "selectedmessage"
    let loading = SwiftLoading()

    
    var message: Mensaje.mensaje!{
        didSet(newMessage){
            self.refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI(){
        
            titleLabel.text = message.title!
            messageTextView.text = message.message!
            defaults.setBool(false, forKey: selectedmessage)

        
        
        
    }
    

//    optional func applicationWillResignActive(_ application: UIApplication){
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
   

}

extension DetailViewController: MessageSelectionDelegate {
    func messageSelected(newMessage: Mensaje.mensaje) {
        message = newMessage
    }
}

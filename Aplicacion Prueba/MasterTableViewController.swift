//
//  MasterTableViewController.swift
//  Aplicacion Prueba
//
//  Created by Miguel Roncallo on 1/25/16.
//  Copyright © 2016 Miguel Roncallo. All rights reserved.
//

import UIKit

protocol MessageSelectionDelegate: class{
    func messageSelected(newMessage: Mensaje.mensaje)
}

class MasterTableViewController: UITableViewController {
    var loading = SwiftLoading()
    var mensaje = Mensaje.message(JSONDecoder(""))
    let defaults = NSUserDefaults.standardUserDefaults()
    let connectionOKKey = "connectionok"
    let selectedmessage = "selectedmessage"
    let connection = Connection()
    var data: NSData? = nil
    weak var delegate: MessageSelectionDelegate?
    var spot: Int = 10000
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        connection.connect()
        loading.showLoading()
        defaults.setBool(true, forKey: selectedmessage)

        
        defaults.addObserver(self, forKeyPath: connectionOKKey, options: NSKeyValueObservingOptions.New, context: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mensaje.messages!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        cell.titleLabel.text = mensaje.messages![indexPath.row].title!
        cell.dismissButton.tag = indexPath.row
        cell.dismissButton.addTarget(self, action: "deleteRow:", forControlEvents: .TouchUpInside)
        
//        dismissButton.tag = indexPath.row
//        dismissButton.addTarget(self, action: "deleteRow:", forControlEvents: .TouchUpInside)
        
        
        if mensaje.messages![indexPath.row].unread!{
            cell.unreadImage.hidden = false
        }else{
            cell.unreadImage.hidden = true
        }
        
        

        // Configure the cell...

        return cell
    }
 
    func deleteRow(sender: UIButton){
        mensaje.messages?.removeAtIndex(sender.tag)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedMessage = self.mensaje.messages![indexPath.row]
        self.mensaje.messages![indexPath.row].unread! = false
        
        
        self.delegate?.messageSelected(selectedMessage)
        defaults.setBool(true, forKey: selectedmessage)

        
        if let detailViewController = self.delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        

        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            mensaje.messages?.removeAtIndex(indexPath.row) 
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }     
    }

    
    @IBAction func dismissAll(sender: AnyObject) {
        mensaje.messages!.removeAll()
        tableView.reloadData()
    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if defaults.boolForKey(connectionOKKey){
            
            self.defaults.setBool(false, forKey: self.connectionOKKey)
            data = connection.data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            mensaje = Mensaje.message(JSONDecoder(data!))
            print(mensaje)
            
            
        }
    }
    

}

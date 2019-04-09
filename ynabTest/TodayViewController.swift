//
//  TodayViewController.swift
//  ynabTest
//
//  Created by Jacob Pyke on 09.04.19.
//  Copyright © 2019 pykeeco. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var counter: Double = 0;
    
    @IBAction func onAdd(_ sender: Any) {
        counter += 10
        printCounter()
    }
    
    @IBAction func onRemove(_ sender: Any) {
        counter -= 10
        printCounter()
    }
    
    @IBAction func onMediumAdd(_ sender: Any) {
        counter += 100
        printCounter()
    }
    
    @IBAction func onMediumRemove(_ sender: Any) {
        counter -= 100
        printCounter()
    }
    
    @IBAction func onBiggestAdd(_ sender: Any) {
        counter += 1000
        printCounter()
    }
    
    @IBAction func onBiggestRemove(_ sender: Any) {
        counter -= 1000
        printCounter()
    }
    
    func printCounter() {
        statusLabel.text = ""
        number.text = "  €" + String(counter / 1000) + "  "
    }
    
    @IBAction func foodPressed(_ sender: Any) {
        postToYNAB(button: "aa4e0b41-1176-4865-a35f-94b03b35dd2a")
    }
    
    @IBAction func giftsPressed(_ sender: Any) {
        postToYNAB(button: "6d231112-3dde-4082-b367-808e9c855f05")
    }
    
    
    
    
    func postToYNAB(button: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        let parameters = ["transaction" : [
            "account_id": accountKey,
            "date": result,
            "amount": counter,
            "category_id": button,
            "memo": "Sent From iOS",
            "approved": true
            ]] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://api.youneedabudget.com/v1/budgets/" + key + "/transactions")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.addValue("Bearer 8ed14022ae78b86077003b8baafacd9e284191c8c8892c90aff40f6b7bd58e65", forHTTPHeaderField: "Authorization")
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        self.statusLabel.text = "Success!"
                    }
                    print(json)
                }
            } catch let error {
                self.statusLabel.text = error.localizedDescription
            }
        })
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

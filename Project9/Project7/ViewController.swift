//
//  ViewController.swift
//  Project7
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/9/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [[String : String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString : String!
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                    return
                } else {
                    showError()
                }
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func parse(json : JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title" : title, "body" : body, "sigs" : sigs]
            petitions.append(obj)
        }
        tableView.reloadData()
    }

    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem in loading the feed; please check your connection and try again", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedVC()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


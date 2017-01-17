//
//  ViewController.swift
//  Sport_Project
//
//  Created by Thanh Tùng on 1/13/17.
//  Copyright © 2017 AllAboutSport. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblHomeDetail: UITableView!
    var arrDescription = [String]() // Description
    var arrImage = [String]() // Image
    var flatDescription:Bool = false //FlatDescription to check <title> descrip
    var flatImage = false //flatImage to check data <img
    var parseRss = XMLParser()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
    }
    
    /// Init Data
    ///
    /// - returns: <#return value description#>
    private func initData(){
        self.tblHomeDetail.register(UINib(nibName: identifier.HOME_CELL, bundle: nil), forCellReuseIdentifier: identifier.HOME_CELL)
        
        self.tblHomeDetail.rowHeight = UITableViewAutomaticDimension
        self.tblHomeDetail.estimatedRowHeight = 44.0 // set to whatever your "average" cell height is
        
        parseRss = XMLParser( contentsOf: ServerPath.urlRss!)!
        parseRss.delegate = self
        parseRss.parse()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Custom tableview for view controller
extension ViewController : UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblHomeDetail.dequeueReusableCell(withIdentifier: identifier.HOME_CELL, for: indexPath) as! HomeCell
        
        cell.lbDescription.text = arrDescription[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }

}


extension ViewController : XMLParserDelegate{

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
        case "title" :
            self.flatDescription = true
        case "image" :
            self.flatImage = true
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch true {
        case flatDescription:
            if string != "Thể thao - Dân trí điện tử - Dantri.com.vn"{
                arrDescription.append(string)
            }
            
        case flatImage:
            arrImage.append(string)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "title":
            self.flatDescription = false
        case "image" :
            self.flatImage = false
        default:
            break
        }
        self.tblHomeDetail.reloadData()
    }
}


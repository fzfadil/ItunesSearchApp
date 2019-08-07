//
//  ViewController.swift
//  altamira
//
//  Created by recep daban on 5.08.2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIActionSheetDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let apiManager = ApiManager()
    let helper = Helper.sharedHelper
    
    var searchActive : Bool = false
    var filteredData : [[String : Any]] = []
    var filteredDataCount : Int = 0
    var searchText : String = ""
    var entityType : String = "all"
    var selectedIds : [Int] = []
    var allSelectedIds : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        changeRightButtonTitle(title: entityType.uppercased())
        
        allSelectedIds = UserDefaults.standard.object(forKey: "selectedIds") as? [Int] ?? allSelectedIds
        selectedIds = allSelectedIds
        
        indicator.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        if selectedIds.isEmpty == false {
             UserDefaults.standard.set(selectedIds, forKey: "selectedIds")
        }
    }
    
    func changeRightButtonTitle(title : String) {
        
        let barButtonItem = UIBarButtonItem(title: "Filter (" + title + ")", style: .plain, target: self, action: #selector(openFilterPopup))
        barButtonItem.tintColor = UIColor.blue
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func makeSearch(parameters: [String: Any]) {
        
        apiManager.makeRequestForSearch(parameters: parameters) { (JSON) in
            if JSON != nil {
                //print(JSON as Any)
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                var data = (JSON?.dictionaryObject)!
                if (data["resultCount"] as? Int) != 0 {
                    self.filteredDataCount = data["resultCount"] as! Int
                    self.filteredData = data["results"] as! [[String : Any]]
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "INFO", message: "Not found anything", preferredStyle: .alert)
                
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.filteredDataCount = 0
                        self.filteredData = []
                        self.tableView.reloadData()
                    }))
                    
                    self.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    @objc func openFilterPopup() {
        self.showAlert(sender:self)
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Filter", message: "Choose search filter", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title:"all", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "all"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"movie", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "movie"
            self.changeRightButtonTitle(title: self.entityType.uppercased())
            self.searchBarTextDidEndEditing(self.searchBar)
        }))
        
        alert.addAction(UIAlertAction(title:"podcast", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "podcast"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"music", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "song"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"musicVideo", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "musicVideo"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"audiobook", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "audiobook"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"shortFilm", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "shortFilm"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"tvShow", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "tvSeason"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"software", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "software"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
        
        alert.addAction(UIAlertAction(title:"ebook", style: .default , handler:{ (UIAlertAction)in
            self.entityType = "ebook"
            self.searchBarTextDidEndEditing(self.searchBar)
            self.changeRightButtonTitle(title: self.entityType.uppercased())
        }))
       
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
// MARK: Searchbar Functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        indicator.isHidden = false
        indicator.startAnimating()
        searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        searchText = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        var params = ["term":searchText]
        if entityType != "all" {
            params["entity"] = entityType
        }
        makeSearch(parameters: params)
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchActive = true
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText
    }
    
// MARK: Tableview Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.resultTitle.text = filteredData[indexPath.row]["trackName"] as? String
        cell.resultKind.text = filteredData[indexPath.row]["kind"] as? String
        cell.resultImg.sd_setImage(with: URL(string:filteredData[indexPath.row]["artworkUrl100"] as! String), placeholderImage: nil)
        
        if filteredData[indexPath.row]["trackId"] != nil {
            if allSelectedIds.contains(filteredData[indexPath.row]["trackId"] as! Int) {
                cell.backgroundColor = UIColor.init(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return helper.getScreenHeight() * 0.15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if filteredData[indexPath.row]["trackId"] != nil {
            selectedIds.append(filteredData[indexPath.row]["trackId"] as! Int)
        }
        
        DispatchQueue.main.async {
            let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            detailVc.detailedData = self.filteredData[indexPath.row]
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
            
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
       
    }

}


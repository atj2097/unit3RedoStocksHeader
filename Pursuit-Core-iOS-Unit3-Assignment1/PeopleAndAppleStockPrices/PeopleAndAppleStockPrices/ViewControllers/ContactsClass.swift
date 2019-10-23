//
//  ContactsClass.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsClass: UIViewController, UISearchBarDelegate {
    var searchNames = [String]()
//    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var contactsView: UITableView!
    var contactData = [Results](){
        didSet {
            DispatchQueue.main.async
                {
                    self.contactsView.reloadData()
            }
        }
    }
    var searchResults = [Results]()
    let searchController = UISearchController(searchResultsController: nil)
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
   
        // Do any additional setup after loading the view.
    }
    func setup() {
        contactsView.dataSource = self
        contactsView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contacts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func fetchData() {
        ContactAPIClient.shared.getContact { (result) in
            switch result {
            case .failure(let error):
                print("Error Code: \(error)")
            case .success(let contact):
                self.contactData = contact.results
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchResults = contactData.filter({( result : Results) -> Bool in
            return result.name.first.lowercased().contains(searchText.lowercased())
        })
        
        contactsView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ContactsClass: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    
}
extension ContactsClass: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return searchResults.count
        }
        
        return contactData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        let result: Results
        if isFiltering() {
            result = searchResults[indexPath.row]
        } else {
            result = contactData[indexPath.row]
        }
        cell.textLabel!.text = result.name.first
        cell.detailTextLabel!.text = result.email
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            print("Segue works")
        if segue.identifier == "showDetail" {
            if let indexPath = contactsView.indexPathForSelectedRow {
                let result: Results
                if isFiltering() {
                    result = searchResults[indexPath.row]
                } else {
                    result = contactData[indexPath.row]
                }
                let controller = (segue.destination as! ContactsDetailViewController)
                controller.detailResult = result
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
}

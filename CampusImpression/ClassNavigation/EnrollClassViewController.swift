//
//  EnrollClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class EnrollClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var isSelected: Bool = false

    // –––––    TODO: Connect TableView outlet
    @IBOutlet weak var tableView: UITableView!
    
    let data = [("ICS", ["31", "33"]),
                ("MGMT", ["115"])]

    var filteredData: [(String, [String])]!, searchController: UISearchController!
    
    // Add Header Identifier
    let HeaderViewIdentifier = "TableViewHeaderView"
    
    var selectedCourse: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = data
        setupSearchController()
        
        // –––––    TODO: Assign tableView.datasource to VC    –––––
        tableView.dataSource = self
        
        // –––––    TODO: Assign tableView.delegate to VC    –––––
        tableView.delegate = self
        
        // –––––    TODO: Refresh tableView    –––––
        tableView.reloadData()
        
        // Register UITableViewHeaderFooterView
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
    }
    
    
    // ––––– SearchBar Functionality –––––
    
    // Create Search Bar
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
    }
    
    // Update tableview as the user types
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredData = data.filter({ (data: (String, [String])) -> Bool in
            let state = data.0
            return state.localizedCaseInsensitiveContains(text)
            
        })
        if filteredData.count == 0 {
            filteredData = data
        }
        tableView.reloadData()
    }
    
    
    // –––––    TODO: Add Table View Functions    –––––
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }
    
    // Number of Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData[section].1.count
    }
    
    // CellforRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as! CoursesTableViewCell
        let citiesInSection = filteredData[indexPath.section].1
        cell.courseLabel.text = citiesInSection[indexPath.row]
        return cell
    }
    
    // Height for section headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // Content of each section header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewIdentifier)
        headerView!.textLabel!.text = filteredData[section].0
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected = true
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as! CoursesTableViewCell
        let citiesInSection = filteredData[indexPath.section].1
        cell.courseLabel.text = citiesInSection[indexPath.row]
        
        let headerText = filteredData[indexPath.section].0
        self.selectedCourse = headerText + " " + cell.courseLabel.text!
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButton(_ sender: Any) {
        if isSelected {
            let query = PFQuery(className: "Courses")
            query.whereKey("user", equalTo: PFUser.current()!)
            query.whereKey("courseTitle", equalTo: self.selectedCourse!)
            print(self.selectedCourse)

            let this_course = self.selectedCourse!
            query.findObjectsInBackground { (selected, error) in
                if selected == [] {
                    let course = PFObject(className: "Courses")
                    course["user"] = PFUser.current()!
                    course["courseTitle"] = this_course
                    course.saveInBackground { (success, error) in
                        if success {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            print("error!")
                        }
                    }
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }
        else {
            self.dismiss(animated: true, completion: nil)
        }

    }
}

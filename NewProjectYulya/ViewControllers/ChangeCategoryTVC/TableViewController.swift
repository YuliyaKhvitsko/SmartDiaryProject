//
//  TableViewController.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 12.07.22.
//

import UIKit

class TableViewController: UITableViewController {
    var articles: [Article] = []
    var savedCategory = ""
    var selectedCategory: String?
    var selectCat: NewsCategory?
    var category =  NewsCategory.allCases
    var selectCategory: ((NewsCategory) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: String(describing: TableViewCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: String(describing: TableViewCell.self))
        tableView.isScrollEnabled = false
    }

    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return category.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
      
        let textData = category[indexPath.row].rawValue
        cell.textLabel?.text = textData
//
//        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCategory?(category[indexPath.row])
        
    }
}

//
//  NewsViewController.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 11.07.22.
//

import UIKit
import SafariServices
import SDWebImage

class NewsViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: String(describing: NewsViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: NewsViewCell.self))
        setupGestures()
       
        downloadNews(category: .general)
    }
    
    private func downloadNews(category: NewsCategory) {
        NetworkManager.getNews(type: category) { result in
            self.articles = result.content
            self.tableView.reloadData()
        } failure: {
            self.title = "Ошибка запроса"
        }
    }
    
//    func hideNavigationBar(){
//           // Hide the navigation bar on the this view controller
//           self.navigationController?.setNavigationBarHidden(true, animated: true)
//
//       }
    
    private func setupGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        button.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        let vc = TableViewController(nibName: String(describing: TableViewController.self), bundle: nil)
        vc.selectCategory = { selectedCategory in
            self.downloadNews(category: selectedCategory)
        }
        vc.modalPresentationStyle = .popover
        
        let popOverVC = vc.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.button
        popOverVC?.sourceRect = CGRect (x: self.button.bounds.midX, y: self.button.bounds.maxY, width: 0, height: 0)
        vc.preferredContentSize = CGSize(width: 150, height: 300)
        
        self.present(vc, animated: true)
    }
    
}

extension NewsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsViewCell.self), for: indexPath) as! NewsViewCell
        
        //        let article = articles[indexPath.row]
        
        
        cell.badgeLabel.text = String(indexPath.row + 1)
        
        cell.configureCell(articles: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = articles[indexPath.row]
        guard let url = item.url else { return }
        
        UIApplication.shared.open(NSURL(string: url)! as URL)
        
//        let backItem = UIBarButtonItem()
//         backItem.title = "Назад"
//        backItem.tintColor = UIColor.white
//         self.navigationItem.backBarButtonItem = backItem
        
    }
    
}


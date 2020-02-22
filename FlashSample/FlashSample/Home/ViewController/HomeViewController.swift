
//  HomeViewController.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResponseLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var presentor:HomeViewPresenterProtocol?
    var items:[Item]?
    
    /**
    Instantiate a controller
     */
    static func instantiateViewController() -> HomeViewController {
        return UIStoryboard.main().instantiateViewController(withIdentifier:
            HomeViewController.className) as! HomeViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewRouter.createHomeViewModule(homeviewRef: self)
        initialSetup()
        activityIndicatorView.startAnimating()
        presentor?.viewDidLoad()
    }
    /**
     Doing the initial setup for the controller
     */
    func initialSetup()  {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.title = FSLocalisationConstants.navigationBarTitle
        self.tableView.accessibilityIdentifier = FSAccessibilityIdentifier.homeTableView
        
    }
}
//MARK:- Presenter protocols
extension HomeViewController:HomeViewProtocol {
    
    func showItems(with items: [Item]) {
        self.noResponseLabel.isHidden = true
        self.items = items
        self.activityIndicatorView.stopAnimating()
        self.tableView.reloadData()
    }
    
    func showAPIError(message:String) {
        self.noResponseLabel.isHidden = false
        self.noResponseLabel.text = message
        self.activityIndicatorView.stopAnimating()
        
    }
    
}
//MARK:- TableView Delegate and Datasource
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemViewCell.className, for: indexPath)
        guard let item = items?[indexPath.row] else {
            return cell
        }
        (cell as? ItemViewCell)?.titleLabel.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}


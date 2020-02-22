//
//  HomeViewPresenter.swift
//  FlashSample
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import UIKit

class HomeViewPresenter:HomeViewPresenterProtocol,HomeViewOutputInteractorProtocol {
 
    var router: HomeViewRouterProtocol?
    var interactor: HomeViewInputInteractorProtocol?
    weak var view: HomeViewProtocol?
    
    func viewDidLoad() {
        interactor?.fetchItemList()
        
    }
    
    /**
     Fetch item list success call back
     */
    func itemListDidFetch(items: [Item]?) {
        if let items = items {
            self.view?.showItems(with: items)
        }
        else {
            self.view?.showAPIError(message: FSLocalisationConstants.navigationBarTitle)
        }
    }
    /**
     Fetch item list failed call back
     */
    func itemListDidFetchFailed(error: Error?) {
        self.view?.showAPIError(message: error?.localizedDescription ?? FSLocalisationConstants.navigationBarTitle)
        
    }
    
}

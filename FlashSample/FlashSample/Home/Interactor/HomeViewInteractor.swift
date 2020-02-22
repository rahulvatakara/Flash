//
//  HomeInteractor.swift
//  FlashSample
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

class HomeViewInteractor: HomeViewInputInteractorProtocol {
    
    weak var presenter: HomeViewOutputInteractorProtocol?
    var apiManager = FSAPIManager()
    
    init(presenter:HomeViewOutputInteractorProtocol) {
        self.presenter = presenter
    }
    
    /**
     Fetch all items
     */
    func fetchItemList() {
        apiManager.fetchHomeData { (response) in
            switch response {
            case let .failure(error):
                self.presenter?.itemListDidFetchFailed(error: error)
                break
            case let .success(items):
                self.presenter?.itemListDidFetch(items: items)
                break
            }
        }
    }
    
    
}

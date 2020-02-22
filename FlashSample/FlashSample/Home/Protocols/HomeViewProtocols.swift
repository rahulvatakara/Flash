
//  HomeViewProtocols.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: class {
    // PRESENTER -> VIEW
    func showItems(with items: [Item])
    func showAPIError(message:String)
}

protocol HomeViewPresenterProtocol: class {
    //View -> Presenter
    var interactor: HomeViewInputInteractorProtocol? {get set}
    var view: HomeViewProtocol? {get set}
    var router: HomeViewRouterProtocol? {get set}
    func viewDidLoad()
}

protocol HomeViewInputInteractorProtocol: class {
    var presenter: HomeViewOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func fetchItemList()
}

protocol HomeViewOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func itemListDidFetch(items: [Item]?)
    func itemListDidFetchFailed(error: Error?)
}

protocol HomeViewRouterProtocol: class {
    //Presenter -> Router
    static func createHomeViewModule(homeviewRef: HomeViewController)
}


//  HomeViewRouter.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import UIKit

class HomeViewRouter: HomeViewRouterProtocol {
    
    /**
     Assemble home module
     */
    static func createHomeViewModule(homeviewRef: HomeViewController) {
        let presenter:HomeViewPresenterProtocol & HomeViewOutputInteractorProtocol = HomeViewPresenter()
        presenter.router = HomeViewRouter()
        presenter.view = homeviewRef
        presenter.interactor = HomeViewInteractor(presenter: presenter)
        homeviewRef.presentor = presenter
    }
}

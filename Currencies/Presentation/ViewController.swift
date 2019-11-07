//
//  ViewController.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

public enum NavigationItems {
    case addButton
    case clear
}

typealias CurrentView = UIView & ViewProtocol

public protocol ViewProtocol: class {
    associatedtype DataType
    var navigationItems: NavigationItems { get }
    func setData(data: DataType?)
    func updateData(data: DataType)
}

public protocol PresenterProtocol: class {
    associatedtype ViewType
    func actionHadling(view: ViewType)
    func attachView(view: ViewType)
    func detachView()
}

final class ViewController<View: CurrentView,Presenter : PresenterProtocol>: UIViewController where View == Presenter.ViewType {
    
    private var currentView: View
    private var presenter: Presenter

    init(currentView: View, presenter: Presenter, titleName: String) {
        self.currentView = currentView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = titleName
    }
    
    override func loadView() {
        self.view = currentView
        presenter.attachView(view: currentView)
        
        switch currentView.navigationItems {
        case .addButton:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                               target: self,
                                                               action: #selector(action(_:)))
        default:
            break
        }
        
        presenter.attachView(view: currentView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        presenter.detachView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @objc func action(_ sender: UIButton) {
        presenter.actionHadling(view: currentView)
    }
    
    func showError() {
        
    }

}

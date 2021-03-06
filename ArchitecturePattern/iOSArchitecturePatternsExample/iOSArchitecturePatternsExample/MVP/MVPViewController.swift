//
//  MVPViewController.swift
//  iOSArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/10/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import UIKit


/// Any presenter that used with the view `MVPViewController` must conform to the protocol `GreetingViewPresenter`
protocol MVPGreetingViewPresenter {
    
    init(view: MVPGreetingView, person: MVPPerson)
    
    // 提供处理事件的接口
    func updatePerson(name: String?)
    func showGreeting()
    func didChangeNameInput(_ input: String?)
}


/// MVPViewController 其实就是 View
class MVPViewController: UIViewController, MVPGreetingView, UITextFieldDelegate {
    
    // MARK: Properties
    
    // View
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var showGreetingButton: UIButton!
    
    // Presenter
    var presenter: MVPGreetingViewPresenter! // 持有 presenter
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subviews 布局代码
        
        // 将事件交给 presenter 处理
        self.presenter.showGreeting()
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(MVPViewController.textFieldDidChangeText(_:)), name: .UITextFieldTextDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    // MARK: User Action -> 将事件交给 presenter 处理
    
    @IBAction func didTapButton(button: UIButton) {
        view.endEditing(true)
        
        self.presenter.showGreeting()
    }
    
    func textFieldDidChangeText(_ notification: NSNotification) {
        
        if let object = notification.object as? UITextField, object == self.nameField {
            self.presenter.didChangeNameInput(self.nameField.text)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.nameField {
            self.presenter.updatePerson(name: textField.text)
        }
    }
    
    // MARK: presenter 处理好数据后，更新 view
    
    func setGreeting(_ greeting: String!) {
        self.greetingLabel.text = greeting
    }
    
    func setGreetingButtonEnabled(_ enabled: Bool!) {
        self.showGreetingButton.isEnabled = enabled
    }
}

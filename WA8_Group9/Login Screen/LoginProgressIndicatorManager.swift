//
//  LoginProgressIndicatorManager.swift
//  WA8_Doshi_6855
//
//  Created by Dhruv Doshi on 11/9/24.
//

import Foundation

extension LoginViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}

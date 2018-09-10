//
//  UIStoryboard+ViewController.swift
//  ios-uiscrollview-demo
//
//  Created by YukiOkudera on 2018/09/11.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

extension UIStoryboard {

    /// Storyboardからインスタンスを取得する
    class func viewController<T: UIViewController>(storyboardName: String, identifier: String) -> T? {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

//
//  DemoViewController.swift
//  ios-uiscrollview-demo
//
//  Created by YukiOkudera on 2018/09/11.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

/// キーボード表示時にスクロールできる画面
final class DemoViewController: UIViewController {

    var navigationTitle = ""

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!

    override func loadView() {
        super.loadView()

        guard let navigationController = self.navigationController else {
            return
        }
        contentViewHeight.constant = UIScreen.main.bounds.size.height
            - navigationController.navigationBar.frame.size.height
            - UIApplication.shared.statusBarFrame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle

        NotificationCenter.default.addObserver(
            self,
            selector: .keyboardWillShow,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: .keyboardWillHide,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

extension DemoViewController {

    @objc fileprivate func keyboardWillShow(_ notification: Notification) {

        guard
            let userInfo = notification.userInfo as? [String: Any],
            let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                return
        }

        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        UIView.animate(withDuration: duration, animations: {
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            self.view.layoutIfNeeded()
        })
    }

    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

extension DemoViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension Selector {
    static let keyboardWillShow = #selector(DemoViewController.keyboardWillShow(_:))
    static let keyboardWillHide = #selector(DemoViewController.keyboardWillHide(_:))
}

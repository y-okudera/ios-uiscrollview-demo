//
//  ListViewController.swift
//  ios-uiscrollview-demo
//
//  Created by YukiOkudera on 2018/09/11.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let titles = ["UITextField in UIScrollView", "UITextView in UIScrollView"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "UIScrollView samples"
    }
}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let vc = UIStoryboard.viewController(
                storyboardName: "Demo2ViewController",
                identifier: "Demo2ViewController") as! Demo2ViewController
            vc.navigationTitle = titles[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        case 1:
            let vc = UIStoryboard.viewController(
                storyboardName: "DemoViewController",
                identifier: "DemoViewController") as! DemoViewController
            vc.navigationTitle = titles[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            print("\(#function) \(indexPath)")
        }
    }
}

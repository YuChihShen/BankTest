//
//  ViewController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewButton1: UIButton!
    @IBOutlet weak var viewButton2: UIButton!
    @IBOutlet weak var viewButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewButton1.addTarget(self, action: #selector(clickButton1), for: .touchUpInside)
        viewButton2.addTarget(self, action: #selector(clickButton2), for: .touchUpInside)
        viewButton3.addTarget(self, action: #selector(clickButton3), for: .touchUpInside)
    }
    
    @objc func clickButton1() {
        let viewController = InfoViewController(nibName: "InfoViewController", bundle: nil)
        viewController.selectedBtn = .btn1
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    @objc func clickButton2() {
        let viewController = InfoViewController(nibName: "InfoViewController", bundle: nil)
        viewController.selectedBtn = .btn2
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    @objc func clickButton3() {
        let viewController = InfoViewController(nibName: "InfoViewController", bundle: nil)
        viewController.selectedBtn = .btn3
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}


//
//  BaseViewController.swift
//  CryptoWallet
//
//  Created by mac on 19.03.23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.09412958473, green: 0.09024820477, blue: 0.1482836902, alpha: 1)
        addViews()
        setupLayout()
        lisenViewModel()
    }
    
    func addViews() {}
    func setupLayout() {}
    func lisenViewModel() {}
    
}

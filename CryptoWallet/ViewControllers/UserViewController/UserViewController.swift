//
//  UserViewController.swift
//  CryptoWallet
//
//  Created by mac on 15.02.23.
//

import UIKit

enum ImageName: String {
    case open = "eye"
    case closed = "eye.slash"
    case background = "background"
    case bitcoin = "bitcoin"
    case down = "arrowtriangle.down.fill"
    case up = "arrowtriangle.up.fill"
    case icon = "iconCrypto"
}

final class UserViewController: BaseViewController {
    
    var userVM: (UserProtocolIn & UserProtocolOut)?
    
    private var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi ", size: 30.0)
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let labelUserName: UILabel = {
        let label = UILabel()
        label.text = "User name"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 12)
        return label
    }()
    
    private let labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Thonburi", size: 12)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var buttonVisibility: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: ImageName.open.rawValue) {
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(clickButtonVisibility), for: .touchUpInside)
        }
        return button
    }()
    
    private let textFieldUserName: UITextField = {
        let textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.2157166302, green: 0.1747339964, blue: 0.3689544797, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8)
        textField.autocorrectionType = .no
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.2157166302, green: 0.1747339964, blue: 0.3689544797, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8)
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = false
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var buttonEnter: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2157166302, green: 0.1747339964, blue: 0.3689544797, alpha: 1)
        button.addButtonRadius()
        button.addTarget(self, action: #selector(pressButtonEnter), for: .touchUpInside)
        return button
    }()
    
    private let labelAuthorizationResult: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 12)
        return label
    }()
    
    private let image: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: ImageName.bitcoin.rawValue)
        image.alpha = 0.3
        return image
    }()
    
    private var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayuot()
        setupStyle()
    }
    
    override func lisenViewModel() {
        guard var userVM = userVM else { return }
        userVM.updateView = { [weak self] text in
            DispatchQueue.main.async {
                self?.labelAuthorizationResult.text = text
            }
        }
    }
    
    override func addViews() {
        [labelLogin, labelUserName, labelPassword, labelAuthorizationResult, textFieldUserName, textFieldPassword, buttonEnter, image].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false})
        
        view.addSubview(image)
        textFieldPassword.addSubview(buttonVisibility)
    }
    
    private func setupStyle() {
        textFieldPassword.rightView = buttonVisibility
        textFieldPassword.rightViewMode = .always
    }
    
    @objc private func pressButtonEnter() {
        guard let userVM = userVM else {
            return
        }
        
        if userVM.userButtonPressed(login: textFieldUserName.noOptionalText, password: textFieldPassword.noOptionalText) {
            UIView.animate(withDuration: 0.4,
                           delay: 0.4,
                           options: [.curveEaseInOut]) {
                self.labelLogin.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.4,
                               delay: 0.0,
                               options: [.curveEaseInOut]) {
                    self.labelUserName.alpha = 0.0
                    self.textFieldUserName.alpha = 0.0
                } completion: { _ in
                    UIView.animate(withDuration: 0.4,
                                   delay: 0.0,
                                   options: [.curveEaseInOut]) {
                        self.labelPassword.alpha = 0.0
                        self.textFieldPassword.alpha = 0.0
                    } completion: { _ in
                        UIView.animate(withDuration: 0.4,
                                       delay: 0.0,
                                       options: [.curveEaseInOut]) {
                            self.buttonEnter.alpha = 0.0
                            self.labelAuthorizationResult.alpha = 0.0
                        } completion: { _ in
                            let loginVC = Builder.build()
                            guard let window = self.view.window else {
                                return
                            }
                            window.switchRootViewController(loginVC)
                        }
                    }
                }
            }
        }
    }
    
    @objc private func clickButtonVisibility() {
        if iconClick {
            textFieldPassword.isSecureTextEntry = true
            if let image = UIImage(systemName: ImageName.closed.rawValue) {
                buttonVisibility.setImage(image, for: .normal)
                buttonVisibility.tintColor = .black
            }
            iconClick = false
        } else {
            textFieldPassword.isSecureTextEntry = false
            if let image = UIImage(systemName: ImageName.open.rawValue) {
                buttonVisibility.setImage(image, for: .normal)
                buttonVisibility.tintColor = .black
            }
            iconClick = true
        }
    }
}

extension UserViewController {
    func setupLayuot() {
        view.addConstraints([
            textFieldUserName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textFieldUserName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            labelUserName.bottomAnchor.constraint(equalTo: textFieldUserName.topAnchor, constant: -5),
            labelUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            labelLogin.bottomAnchor.constraint(equalTo: labelUserName.topAnchor, constant: -25),
            labelLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldUserName.bottomAnchor, constant: 10),
            labelPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 5),
            textFieldPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textFieldPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            buttonEnter.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 30),
            buttonEnter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonEnter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            labelAuthorizationResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelAuthorizationResult.topAnchor.constraint(equalTo: buttonEnter.bottomAnchor, constant: 15),
            
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: 270),
            
            buttonVisibility.topAnchor.constraint(equalTo: textFieldPassword.topAnchor, constant: 0),
            buttonVisibility.trailingAnchor.constraint(equalTo: textFieldPassword.trailingAnchor, constant: 0),
            buttonVisibility.bottomAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 0),
            buttonVisibility.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}

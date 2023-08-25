//
//  WalletViewController.swift
//  CryptoWallet
//
//  Created by mac on 20.02.23.
//

import UIKit

enum Identifier: String {
    case WalletTableViewCell
}
enum FlagSorted {
    case origin
    case sorted
}

final class WalletViewController: BaseViewController {
    var walletVM: (WalletProtocolIn & WalletProtocolOut)?
    
    init(walletVM: WalletProtocolIn & WalletProtocolOut) {
        self.walletVM = walletVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 3
        return tableView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        activityView.hidesWhenStopped = true
        activityView.startAnimating()
        return activityView
    }()
    
    private lazy var buttonLogOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1570645571, green: 0.1514831483, blue: 0.254172802, alpha: 0.9696157089)
        button.addButtonRadius()
        button.addTarget(self, action: #selector(pressButtonLogOut), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonSorted: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sorted", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1570645571, green: 0.1514831483, blue: 0.254172802, alpha: 0.9696157089)
        button.addButtonRadius()
        button.addTarget(self, action: #selector(pressButtonSorted), for: .touchUpInside)
        return button
    }()
    
    var flagSorted = FlagSorted.origin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("срабатывает")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        walletVM?.getData()
    }
    
    private func setupTableView() {
        tableView.register(WalletTableViewCell.self, forCellReuseIdentifier: Identifier.WalletTableViewCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func addViews() {
        [buttonLogOut, buttonSorted, activityView, tableView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    override func setupLayout() {
        view.addConstraints([
            buttonLogOut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            buttonLogOut.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonLogOut.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            
            buttonSorted.topAnchor.constraint(equalTo: buttonLogOut.topAnchor, constant: 0),
            buttonSorted.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            buttonSorted.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            tableView.topAnchor.constraint(equalTo: buttonLogOut.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            activityView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    override func lisenViewModel() {
        guard var walletVM = walletVM else { return }
        
        walletVM.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.activityView.stopAnimating()
        }
        
        walletVM.showError = { [weak self] error in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.activityView.stopAnimating()
            self.showAlert(with: error.localizedDescription)
        }
    }
    
    @objc private func pressButtonLogOut() {
        AuthorizationSettings.shared.isAuth = false
        let loginVC = UserBuilder.build()
        guard let window = self.view.window else {
            return
        }
        window.switchRootViewController(loginVC)
    }
    
    @objc private func pressButtonSorted() {
        activityView.startAnimating()
        walletVM?.dataSortedCoins = .sorted
        tableView.reloadData()
        activityView.stopAnimating()
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coinVC = walletVM?.sortedCoins()[indexPath.row]
        guard let coinVC = coinVC else {return}
        let vc = CoinViewController(model: coinVC)
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let walletVM = walletVM else { return 0 }
        return walletVM.height(forRowAt: indexPath)
    }
}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let walletVM = walletVM else { return 0 }
        return walletVM.sortedCoins().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.WalletTableViewCell.rawValue) as? WalletTableViewCell, let walletVM = walletVM else { return UITableViewCell() }
        cell.layer.borderWidth = 5
        cell.layer.borderColor = view.backgroundColor?.cgColor
        
        cell.setupCell(with: walletVM.sortedCoins()[indexPath.row])
        
        return cell
    }
}


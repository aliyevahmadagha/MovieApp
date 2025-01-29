//
//  LoginController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit

final class LoginController: BaseController {
    
    private lazy var goRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.purple, for: .normal)
        button.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        button.setTitle("Don’t you have an account", for: .normal)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        button.backgroundColor = .purple
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField])
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = " ahmadagha@gmail.com"
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.purple.cgColor
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = " ********"
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.purple.cgColor
        return field
    }()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func loginClicked() {
        
        guard let email = emailField.text, let password = passwordField.text else {
            showMessage(message: "fields can not be empty", actionTitle: "Ok")
            return
        }
        guard email.count >= 5, password.count  >= 8 else {
            showMessage(message: "wrong email or password format", actionTitle: "Ok")
            return
        }
        viewModel.checkUser(email: email, password: password)
        defaults.set(true, forKey: "isLogin")
        rootNotification()
    }
    
    fileprivate func configureViewModel() {
        viewModel.requestCallback = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .success:
                defaults.set(true, forKey: "isLogin")
                rootNotification()
            case .error(let error):
                defaults.set(false, forKey: "isLogin")
                self.showMessage(message: "There is some a problem", actionTitle: "Ok")
            }
        }
    }
    
    fileprivate func rootNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("switchRoot"), object: nil)
    }
    
    @objc private func showRegister() {
        viewModel.showRegister()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(scrollView)
        view.addSubview(loginButton)
        view.addSubview(goRegisterButton)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        goRegisterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 36),
            passwordField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            goRegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            goRegisterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            goRegisterButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 4),
        ])
    }
}

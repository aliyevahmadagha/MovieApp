//
//  RegisterController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 29.01.25.
//

import UIKit

final class RegisterController: BaseController {
    
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
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
    
    @objc private func registerButtonClicked() {
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty else {
            showMessage(title: "", message: "Fields cannot be empty", actionTitle: "Ok")
            return
        }
        
        guard email.count > 5 else {
            showMessage(message: "wrong email format", actionTitle: "Ok")
            return
        }
        
        guard password.count >= 8 else {
            showMessage(message: "The password cannot be less than 8 characters.", actionTitle: "Ok")
            return
        }
        viewModel.createUser(email: email, password: password)
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(scrollView)
        view.addSubview(registerButton)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
            registerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 36),
            passwordField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
    }
}
    

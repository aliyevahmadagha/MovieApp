//
//  RegisterViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 29.01.25.
//

final class RegisterViewModel {
    
    enum ViewState {
        case success
        case error(String)
    }
    
    private let helper: FireBaseHelper
    private let navigation: AuthNavigation
    
    var requestCallback: ((ViewState) -> Void)?
    var callback: ((String, String) -> Void)?
    
    init(navigation: AuthNavigation) {
        self.navigation = navigation
        self.helper = FireBaseHelper()
    }
    
    func createUser(email: String, password: String) {
        helper.register(email: email, password: password) { [weak self] dto, error in
            guard let self = self else {return}
            guard let _ = dto else {
                self.requestCallback?(.error("\(error ?? "error")"))
                return
            }
            self.requestCallback?(.success)
        }
    }
    
    func backLogin() {
        navigation.showLogin()
    }
}

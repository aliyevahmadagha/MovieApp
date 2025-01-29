//
//  LoginViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

final class LoginViewModel {
    
    enum ViewState {
        case success
        case error(String)
    }
    
    let navigation: AuthNavigation
    let helper: FireBaseHelper
    
    var requestCallback: ((ViewState) -> Void)?
    
    init(navigation: AuthNavigation) {
        self.navigation = navigation
        self.helper = FireBaseHelper()
    }
    
    func showRegister() {
        navigation.showRegister()
    }
    
    
    func checkUser(email: String, password: String) {
        helper.login(email: email, password: password) { [weak self] dto, error in
            guard let self = self else {return}
            guard let dto = dto else {
                self.requestCallback?(.error("\(error ?? "there is not user")"))
                return
            }
            self.requestCallback?(.success)
        }
    }
}

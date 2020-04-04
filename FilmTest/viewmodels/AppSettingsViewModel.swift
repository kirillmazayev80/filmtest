//
//  AppSettingsViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class AppSettingsViewModel: Messagable {
    
    var errorMessages = PassthroughSubject<String, Never>()
    var selectedTheme = Observable<Theme?>(nil)
    var selectedGenreName = Observable<String?>(nil)
    
    init() { self.setSettings() }
    
    fileprivate func setSettings() {
        selectedTheme.value = ThemeManager.currentTheme()
        let genreName = UserDefaults.standard.string(forKey: Utils.GENRE_NAME)
        selectedGenreName.value = genreName
    }
    
    func updateSettings() { setSettings() }
    
}

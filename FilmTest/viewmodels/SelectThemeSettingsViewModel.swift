//
//  SelecThemeSettingsViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class SelectThemeSettingsViewModel {
    
    let themes = MutableObservableArray<Theme>([.light, .dark])
    
    func applyTheme(_ selectedTheme: Theme) {
        switch (selectedTheme) {
            case .light: ThemeManager.applyTheme(theme: selectedTheme)
            case .dark: ThemeManager.applyTheme(theme: selectedTheme)
        }
    }
    
}

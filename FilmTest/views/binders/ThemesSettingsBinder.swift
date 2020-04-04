//
//  ThemesSettingsBinder.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 19.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class ThemesSettingsBinder<Changeset: SectionedDataSourceChangeset>:
TableViewBinderDataSource<Changeset> where Changeset.Collection == Array<Theme> {
    
    @objc override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTheme = ThemeManager.currentTheme()
        let cell = tableView.dequeueReusableCell(withIdentifier: Utils.THEME_CELL, for: indexPath)
        guard let theme = changeset?.collection[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = theme.rawValue
        if theme == currentTheme {
            cell.setCellType(.checkmark, .lightGray, .white)
        } else {
            cell.setCellType(.none, .white, .black)
        }
        return cell
    }
    
}

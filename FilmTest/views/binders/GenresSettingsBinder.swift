//
//  GenresSettingsCustomBinder.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 19.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class GenresSettingsBinder<Changeset: SectionedDataSourceChangeset>:
TableViewBinderDataSource<Changeset> where Changeset.Collection == Array<Genre> {
    
    @objc override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Utils.GENRE_CELL, for: indexPath)
        guard let genre = changeset?.collection[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = genre.name
        if genre.name == UserDefaults.standard.string(forKey: Utils.GENRE_NAME) {
            cell.setCellType(.checkmark, .lightGray, .white)
        } else {
            cell.setCellType(.none, .white, .black)
        }
        return cell
    }
    
}

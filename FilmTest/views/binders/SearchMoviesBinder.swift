//
//  SearchMoviesBinder.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 12.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class SearchMoviesBinder<Changeset: SectionedDataSourceChangeset>:
    TableViewBinderDataSource<Changeset> where Changeset.Collection == Array<Movie> {
    
    @objc override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Utils.MOVIE_CELL, for: indexPath) as! MovieCell
        guard let movie = changeset?.collection[indexPath.row] else { return MovieCell() }
        cell.configureCell(with: movie)
        return cell
    }
    
}

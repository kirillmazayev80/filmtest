//
//  FavoritesMoviesBinder.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 12.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class FavoritesMoviesBinder<Changeset: SectionedDataSourceChangeset>:
    CollectionViewBinderDataSource<Changeset> where Changeset.Collection == Array<Movie> {
    
    @objc override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Utils.FAVORITES_CELL, for: indexPath) as! FavoritesCell
        guard let movie = changeset?.collection[indexPath.row] else { return FavoritesCell() }
        cell.configureCell(with: movie)
        return cell
    }

}

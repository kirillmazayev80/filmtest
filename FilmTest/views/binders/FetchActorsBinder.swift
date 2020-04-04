//
//  FetchActorsBinder.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class FetchActorsBinder<Changeset: SectionedDataSourceChangeset>:
TableViewBinderDataSource<Changeset> where Changeset.Collection == Array<Actor> {
    
    @objc override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Utils.ACTOR_CELL, for: indexPath) as! ActorCell
        guard let actor = changeset?.collection[indexPath.row] else { return ActorCell() }
        cell.configureCell(with: actor)
        return cell
    }
    
}

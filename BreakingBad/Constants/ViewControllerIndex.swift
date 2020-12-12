//
//  ViewControllerIndex.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

struct ViewControllerIndex {
    static var charactorListView: UIViewController {
        let listView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharactersListViewController") as? CharactersListViewController
        return listView!
    }
    
    static var charectorDetailView: CharacterDetailViewController {
        let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController
        return detailView!
    }
}

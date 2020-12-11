//
//  ViewControllerIndex.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

struct ViewControllerIndex {
    static var charectorListView: UIViewController {
        let listView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharectorsListViewController") as? CharectorsListViewController
        return listView!
    }
    
    static var charectorDetailView: UIViewController {
        let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharectorDetailViewController") as? CharectorDetailViewController
        return detailView!
    }
}

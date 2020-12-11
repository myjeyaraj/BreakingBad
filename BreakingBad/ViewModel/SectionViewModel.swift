//
//  SectionViewModel.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import Foundation

import RxDataSources


protocol BreakingSectionModelType: SectionModelType {
    var header: String { get set }
}

struct SectionViewModel {
    var header: String
    var items: [Item]
}

extension SectionViewModel: BreakingSectionModelType {
    typealias Item = Any
    
    init(original: SectionViewModel, items: [Item]) {
        self = original
        self.items = items
    }
}

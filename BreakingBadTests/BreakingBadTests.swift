//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import XCTest
import RxDataSources
import RxSwift
import RxCocoa

@testable import BreakingBad

class BreakingBadTests: XCTestCase {
    let viewModel = CharectorListViewModel()
    let viewController = CharectorListViewModel()
let disposeBag = DisposeBag()
    
    
    override func setUpWithError() throws {
        viewModel.loadCharectors()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForDataSource() {
        let results = viewModel.dataSource
        results.asObservable()
            .filter{$0.count < 0}
            .subscribe(onNext: { v in
                XCTAssertNil(v)

            })
            .disposed(by: disposeBag)
    }
  
    
    func testUrlImageFail(){
       let dd = CharacterCellDetail(primaryTitle: "", secondaryTitle: "")
         let ss = dd as ImageProtocol
            XCTAssertNil(ss)

    }
    
}

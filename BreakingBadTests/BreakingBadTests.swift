//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import RxCocoa
import RxDataSources
import RxSwift
import XCTest

@testable import BreakingBad

class BreakingBadTests: XCTestCase {
    let viewModel = CharectorListViewModel()
    let disposeBag = DisposeBag()
    let data = ReplaySubject<[BreakingBadUser]?>.create(bufferSize: 1)

    struct MockStrut {
        var name: String
        var occupation: String
    }

    func loadCharectors() {
        Request.breakingBadCharectors { [weak self] result in
            switch result {
            case let .success(response):
                self?.data.onNext(response)
                break
            case .failure:
                break
            }
        }
    }

    override func setUpWithError() throws {
        loadCharectors()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForDataSource() {
        let results = viewModel.dataSource
        results.asObservable()
            .filter { $0.count < 0 }
            .subscribe(onNext: { v in
                XCTAssertNil(v)

            })
            .disposed(by: disposeBag)
    }

    func testDataLoding() {
        let e = expectation(description: "true")
        data.subscribe(onNext: {
            print($0?.count ?? 0 > 0)
            e.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testUserHasManyAppearance() {
        let e = expectation(description: "true")
        data.subscribe(onNext: {
            $0?.forEach {
                print($0.occupation.count > 10)
            }
            e.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testUserHasManyOccupation() {
        let e = expectation(description: "true")
        data.subscribe(onNext: {
            $0?.forEach {
                XCTAssert($0.occupation.count > 0)
                XCTAssertTrue($0.occupation.count == 0)
                XCTAssertEqual($0.occupation.count, 10)
            }
        })
            .disposed(by: disposeBag)
        e.fulfill()
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testUrlImageFail() {
        let dd = CharacterCellDetail(primaryTitle: "", secondaryTitle: "")
        let ss = dd as ImageProtocol
        XCTAssertNil(ss)
    }
}

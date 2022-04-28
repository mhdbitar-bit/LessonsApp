//
//  LessonsListViewControllerTests.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/28/22.
//

import XCTest
@testable import LessonsApp

class LessonsListViewControllerTests: XCTestCase {
    func test_canInit() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.tableView)
    }
    
    func test_configureTableView() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.tableView.delegate, "Expeted TableViewDelegate to be not nil")
        XCTAssertNotNil(sut.tableView.dataSource, "Expeted TableViewDataSrouce to be not nil")
    }
    
    func test_viewDidLoad_initialState() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    private func makeSUT() -> LessonsListViewController {
        let client = URLSessionHTTPClient(session: .shared)
        let remoteService = RemoteLessonsService(url: anyURL(), client: client)
        let remoteImageService = RemoteImageDataService(client: client)
        let remoteVideoService = RemoteVideoService(client: client)
        
        let viewModel = LessonListViewModel(
            lessonService: remoteService,
            imageDataService: remoteImageService,
            videoDataService: remoteVideoService)
        let sut = LessonsListViewController(viewModel: viewModel)
        
        return sut
    }
}

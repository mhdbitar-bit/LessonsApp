//
//  SharedTestHelpers.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation
@testable import LessonsApp

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyNSError() -> NSError {
    return NSError(domain: "", code: 0)
}

func anyResponse() -> HTTPURLResponse {
    return HTTPURLResponse(statusCode: 200)
}

func makeJson(_ lessons: [[String: Any]]) -> Data {
    let json = ["lessons": lessons]
    return try! JSONSerialization.data(withJSONObject: json)
}

func makeLesson(id: Int, name: String, description: String, thumbnail: URL, videoUrl: URL) -> (model: Lesson, json: [String: Any]) {
    let lesson = Lesson(id: id, name: name, description: description, thumbnail: thumbnail, videoUrl: videoUrl)
    
    let json = [
        "id": id,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "videoUrl": videoUrl
    ] as [String : Any]
    
    return (lesson, json)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(
            url: anyURL(),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil)!
    }
}


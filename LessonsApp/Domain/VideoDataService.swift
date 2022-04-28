//
//  DownloadService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

protocol VideoDataService {
    typealias Result = Swift.Result<URL, Error>
    
    func loadVideo(from url: URL, completion: @escaping (Result) -> Void)
}

//
//  RemoteDownloadService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

final class RemoteVideoService: VideoDataService {
    typealias Result = VideoDataService.Result
    
    private let client: HTTPDownloadClient
    
    init(client: HTTPDownloadClient) {
        self.client = client
    }
    
    func loadVideo(from url: URL, completion: @escaping (Result) -> Void) {
        client.download(from: url) { result in
            switch result {
            case .success(let (fileURL, response)):
                guard response.statusCode == 200 else {
                    return completion(.failure(NetworkError.invalidData))
                }
                do {
                    if let savedURL = try RemoteVideoService.saveVideo(fileURL) {
                        completion(.success(savedURL))
                    } else {
                        completion(.failure(CacheError.failed))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure:
                completion(.failure(NetworkError.connectivity))
            }
        }
    }
    
    private static func saveVideo(_ fileURL: URL) throws -> URL? {
        do {
            let documentsURL = try
            FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
            try FileManager.default.moveItem(at: fileURL, to: savedURL)
            return savedURL
        } catch {
            throw CacheError.failed
        }
    }
}

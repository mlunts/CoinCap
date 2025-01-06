//
//  MockURLSession.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//

class MockURLSession: URLSessionProtocol {
    var dataResult: Result<(Data, URLResponse), Error>
    
    init(dataResult: Result<(Data, URLResponse), Error>) {
        self.dataResult = dataResult
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        switch dataResult {
        case .success(let dataAndResponse):
            return dataAndResponse
        case .failure(let error):
            throw error
        }
    }
}

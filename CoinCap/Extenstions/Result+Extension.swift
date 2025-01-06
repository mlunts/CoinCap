//
//  Result+Extension.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//

extension Result where Success: Equatable, Failure: Error {
    func isEqual(to other: Result<Success, Failure>) -> Bool {
        switch (self, other) {
        case (.success(let lhsValue), .success(let rhsValue)):
            return lhsValue == rhsValue
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}

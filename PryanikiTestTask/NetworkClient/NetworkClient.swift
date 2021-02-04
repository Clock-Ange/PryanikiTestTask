//
//  NetworkClient.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 02.02.2021.
//

import Foundation
import Alamofire

//MARK: -Singleton
final class NetworkClient {
    typealias result = (Result<ServerData,Error>) -> ()
    public static let shared = NetworkClient()
}
//MARK: -Parsing data method
extension NetworkClient {
    public func parseData(completion: @escaping result){
        AF.request("https://pryaniky.com/static/json/sample.json").responseJSON {
            if let data = $0.data {
                do {
                    let serverData = try JSONDecoder().decode(ServerData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(serverData))
                    }
                } catch let parsingError{
                    print("Error occured: \(parsingError.localizedDescription)")
                    completion(.failure(parsingError))
                    return
                }
            }
        }
    }
}

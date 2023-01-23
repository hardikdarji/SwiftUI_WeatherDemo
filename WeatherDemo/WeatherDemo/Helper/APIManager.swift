//
//  APIManager.swift
//
//  Created by Hardik Darji on 22/01/23.
//

import Foundation

class APIManager{
    //static let shared = APIManager()
    func fetch<T: Decodable>(strUrl: String,
                                   type: RequestType = .GET,
                                   objectType: T.Type,
                                   para: [String: Any]? = nil) async -> Result<T>
    {
        //create url
        guard let url = URL(string: strUrl)
        else { return Result.failure(AppError.badURL(strUrl))}
        
        // ... some asynchronous networking code ...
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let code = (response as? HTTPURLResponse)?.statusCode,
                  code == 200 else {
                return Result.failure(AppError.invalidStatusCode((response as? HTTPURLResponse)!.statusCode))
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return Result.success(decodedObject)
            }
            catch let error{
                return Result.failure(AppError.jsonParsingError(error))
            }
        }catch let error{
            return Result.failure(AppError.badResponse(error))
        }
    }
    
}

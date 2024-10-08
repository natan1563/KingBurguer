//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Natã Romão on 11/04/23.
//

import Foundation

class WebServiceAPI {
    
    static let apiKey = "333a55aa-4843-4ce2-b1d2-533ca0a75d14"
    static let baseURL = "https://hades.tiagoaguiar.co/kingburguer"
    
    static let shared = WebServiceAPI()
    
    enum Endpoint: String {
        case createUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case feed = "/feed"
        case highlight = "/highlight"
        case productDetail = "/products/%d"
        case coupon = "/products/%d/coupon"
        case me = "/users/me"
    }
    
    enum Method: String {
        case post
        case put
        case get
        case delete
    }
    
    enum NetworkError {
        case unauthorized
        case badRequest
        case notFound
        case internalError
        case unknown
    }
    
    enum Result {
        case success(Data?)
        case failure(NetworkError, Data?)
    }
    
    private func completeUrl(path: String) -> URLRequest? {
        let endpoint = "\(WebServiceAPI.baseURL)\(path)"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return nil
        }
        return URLRequest(url: url)
    }
    
    func call(path: String, method: Method, completion: @escaping (Result) -> Void) {
        makeRequest(path: path, body: nil, method: method , completion: completion)
    }
    
    func call<R: Encodable>(path: Endpoint, body: R?, method: Method, completion: @escaping (Result) -> Void) {
        makeRequest(path: path.rawValue, body: body, method: method, completion: completion)
    }
    
    func makeRequest(path: String, body: Encodable?, method: Method, completion: @escaping (Result) -> Void) {
        do {
            guard var request = completeUrl(path: path) else { return }

            request.httpMethod = method.rawValue.uppercased()
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            
            if let accessToken = LocalDataSource.shared.getUserAuth()?.accessToken {
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        
            
            if let body = body {
                let jsonRequest = try JSONEncoder().encode(body)
                request.httpBody = jsonRequest
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print("Response is \(String(describing: response))")
                print("----------------------------\n\n")
                
                if let error = error {
                    print(error)
                    completion(.failure(.internalError, error.localizedDescription.data(using: .utf8)))
                    return
                }
                
                if let r = response as? HTTPURLResponse {
                    switch r.statusCode {
                        case 200:
                            completion(.success(data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                            break
                        case 404:
                            completion(.failure(.notFound, data))
                            break
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 500:
                            completion(.failure(.internalError, data))
                            break
                        default:
                            completion(.failure(.unknown, data))
                            break
                    }
                }
                
            }
            
            task.resume()
        } catch {
            print(error)
            return
        }
        

    }
    
}

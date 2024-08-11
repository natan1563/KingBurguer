//
//  ProductDetailRemoteDataSource.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

class ProductDetailRemoteDataSource {
    
    static let shared = ProductDetailRemoteDataSource()
    
    func fetch(id: Int, completion: @escaping (ProductResponse?, String?) -> Void) {
        let path = String(format: WebServiceAPI.Endpoint.productDetail.rawValue, id)
        
        WebServiceAPI.shared.call(path: path, method: .get) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(ProductResponse.self, from: data)
                    completion(response, nil)
                    break
                    
                case .failure(let error, let data):
                    guard let data = data else { return }
                    
                    switch error {
                        case .unauthorized:
                            let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                            completion(nil, response?.detail.message)
                            break
                            
                        case .internalError:
                            completion(nil, String(data: data, encoding: .utf8))
                            break
                            
                        default:
                            let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                            completion(nil, response?.detail)
                            break
                    }
                    
                    break
            }
        }
    }
    
    func createCoupon(id: Int, completion: @escaping (CouponResponse?, String?) -> Void) {
        let path = String(format: WebServiceAPI.Endpoint.coupon.rawValue, id)
        
        WebServiceAPI.shared.call(path: path, method: .post) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(CouponResponse.self, from: data)
                    completion(response, nil)
                    break
                    
                case .failure(let error, let data):
                    guard let data = data else { return }
                    
                    switch error {
                        case .unauthorized:
                            let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                            completion(nil, response?.detail.message)
                            break
                            
                        case .internalError:
                            completion(nil, String(data: data, encoding: .utf8))
                            break
                            
                        default:
                            let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                            completion(nil, response?.detail)
                            break
                    }
                    
                    break
            }
        }
    }
        
    
}

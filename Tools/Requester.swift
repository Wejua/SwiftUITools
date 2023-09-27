//
//  Requester.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/8.
//

import Foundation

public struct Requester {
    
    public enum RequestMethod: Int, CaseIterable {
        case GET
        case POST
    }
    
    public static func request<T:Codable>(method: RequestMethod, otherHeader: [String:String], urlString: String, parameters:[String:Any], mapModel: T.Type, completionInMain:@escaping (_ model: T?, _ error: Error?) -> Void) {
        Requester.request(method: .GET, otherHeader: otherHeader, urlString: urlString, parameters: parameters) { data, error in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                decoder.nonConformingFloatDecodingStrategy =  .convertFromString(positiveInfinity: "+veInfinity", negativeInfinity: "-veInfinity", nan: "nan")
                let model = try decoder.decode(T.self, from: data)
                completionInMain(model, nil)
            } catch let error {
                fatalError("Error decoding: \(error)")
            }
        }
    }

    public static func request(method: RequestMethod, otherHeader: [String:String], urlString: String, parameters: [String:Any], completionInMain:@escaping (_ data: Data?, _ error: Error?) -> Void) {
        
        let urlRequest = setupRequest(method: method, otherHeader: otherHeader, urlString: urlString, parameters: parameters)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completionInMain(data, nil)
                } else {
                    completionInMain(nil, error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    public static func request(method: RequestMethod, otherHeader: [String:String], urlString: String, parameters: [String:Any]) async throws -> Data {
        let urlRequest = setupRequest(method: method, otherHeader: otherHeader, urlString: urlString, parameters: parameters)
        let (data, _)  = try await URLSession.shared.data(for: urlRequest)
        return data
    }
    
    static private func setupRequest(method: RequestMethod, otherHeader: [String:String], urlString: String, parameters: [String:Any]) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("URL格式错误")
        }
        
        var urlRequest: URLRequest
        if (method == .GET) {
            let queryItems = parameters.map({ (key: String, value: Any) in
                URLQueryItem(name: key, value: "\(value)" )
            })
            var components = URLComponents(string: urlString)
            components?.queryItems = queryItems
            guard let url = components?.url else { fatalError("GET请求参数设置失败") }
            
            urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod = "GET"
        } else {
            urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod = "POST"
            let jsonBody = try? JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = jsonBody
        }
        otherHeader.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
}




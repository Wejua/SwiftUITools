//
//  AdministrativeDivisions.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/29.
//

import Foundation

public class AdministrativeDivisions {
    public static let provinces: [Province] = {
        let classObject = AdministrativeDivisions.self
        let bundle = Bundle(for: classObject) //Mach-o Type为静态库时, 和Bundle.main是一个地址
        
//        let frameworkName = String(reflecting: classObject).split(separator: ".")[0]
//        let fileUrl = URL(fileURLWithPath:bundle.bundlePath).deletingLastPathComponent().appending(component: "\(frameworkName).framework/adc.json")
        
        let fileUrl = bundle.url(forResource: "adc", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let provinces = try! JSONDecoder().decode([Province].self, from: data)
        return provinces
    }()
}

public struct Province: Codable {
    public var provinceCode: String
    public var provinceName: String
    public var cities: [City]
    
    enum CodingKeys: String, CodingKey {
        case provinceCode = "code"
        case provinceName = "name"
        case cities = "children"
    }
}

public struct City: Codable {
    public var cityCode: String
    public var cityName: String
    public var districts: [District]
    
    enum CodingKeys: String, CodingKey {
        case cityCode = "code"
        case cityName = "name"
        case districts = "children"
    }
}

public struct District: Codable {
    public var districtCode: String
    public var districtName: String
    
    enum CodingKeys: String, CodingKey {
        case districtCode = "code"
        case districtName = "name"
    }
}

//
//  Json+Helper.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

class Json {

    typealias JsonDecoderOperationCompletion<Value> = ((JsonDecoderOperation<Value>) -> Void)

    enum JsonDecoderOperation<Value> {
        case success(Value)
        case failure(String?)
    }

    enum JsonDecoderError: LocalizedError {
        case fileNotFound(String)
        case decodationFailure(String)
        case corruptedData(String)

        var errorDescrition: String? {
            switch self {
            case .fileNotFound(let filename):
                return String(format: "%@ - Not Found!", filename)
            case .decodationFailure(let filename):
                return String(format: "%@ - Decodation Failure!", filename)
            case .corruptedData(let filename):
                return String(format: "%@ - Corrupted Data!", filename)
            }
        }
    }

    func from<T: Decodable>(_ filename: String, type: T.Type, completionHandler: JsonDecoderOperationCompletion<T>?) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            completionHandler?(.failure(JsonDecoderError.fileNotFound(String(format: "%@.json", filename)).errorDescrition))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let object = try JSONDecoder().decode(type.self, from: data)
                completionHandler?(.success(object))
                return
            } catch {
                completionHandler?(.failure(JsonDecoderError.decodationFailure(String(format: "%@.json", filename)).errorDescrition))
                return
            }
        } catch {
            completionHandler?(.failure(JsonDecoderError.corruptedData(String(format: "%@.json", filename)).errorDescrition))
            return
        }
    }
}

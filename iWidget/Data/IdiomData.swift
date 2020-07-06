//
//  IdiomData.swift
//  iWidget
//
//  Created by Littleor on 2020/7/6.
//

import Foundation
struct Idiom {
    let word: String
    let pinyin: String
    let explanation: String
    let derivation: String
    let example: String
}
struct IdiomLoader {
    static func fetch(completion: @escaping (Result<Idiom, Error>) -> Void) {
        let IdiomURL = URL(string: "https://idiom.sixming.com/get.php")!
        let task = URLSession.shared.dataTask(with: IdiomURL) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let oneWord = getIdiomInfo(fromData: data!)
            completion(.success(oneWord))
        }
        task.resume()
    }

    static func getIdiomInfo(fromData data: Foundation.Data) -> Idiom {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let word = json["word"] as! String
        let pinyin = json["pinyin"] as! String
        let explanation = json["explanation"] as! String
        let derivation = json["derivation"] as! String
        let example = json["example"] as! String
        return Idiom(word: word,pinyin: pinyin,explanation: explanation,derivation: derivation,example: example)
    }
}

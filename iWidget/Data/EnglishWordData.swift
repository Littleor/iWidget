//
//  EnglishWordData.swift
//  iWidget
//
//  Created by Littleor on 2020/7/13.
//


import Foundation
struct EnglishWord: Codable{
    let word: String
    let tran: [String]
    let ch_example: String
    let en_example: String
    let exam: [String]
    let uspronunciation: String
    let ukpronunciation: String
    let type: String
}

struct EnglishWordLoader {
    
    static func fetch(type: EnglishWordType,completion: @escaping (Result<[EnglishWord], Error>) -> Void) {
        let param:String
        switch(type){
        case .cET4:
            param = "CET4"
        case .cET6:
            param = "CET6"
        case .tOEFL:
            param = "TOEFL"
        case .gRE:
            param = "GRE"
            default:
            param = "CET4"
        }
        let englishWordURL = URL(string: "https://idiom.sixming.com/getWord.php?type=\(param)")!
        let task = URLSession.shared.dataTask(with: englishWordURL) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let decoder = JSONDecoder()
            if let words = try? decoder.decode([EnglishWord].self, from: data!) {
                completion(.success(words))
            }
            else{
                completion(.failure(error!))
            }
        }
        task.resume()
    }
}

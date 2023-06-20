//
//  String+Extentions.swift
//  FourChan
//
//  Created by Yeldos Marat on 20.06.2023.
//

import Foundation

extension String {
    func formatDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/yy(EEE)HH:mm:ss"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ru_RU")
            outputFormatter.dateFormat = "d MMMM, HH:mm"
            
            let formattedDate = outputFormatter.string(from: date)
            return "Сегодня \(formattedDate)"
        }
        
        return nil
    }
    
    func parseHTML() -> NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            print("HTML parsing error: \(error)")
            return nil
        }
    }
}


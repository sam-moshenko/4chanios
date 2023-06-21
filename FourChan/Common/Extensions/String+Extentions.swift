//
//  String+Extentions.swift
//  FourChan
//
//  Created by Yeldos Marat on 20.06.2023.
//

import Foundation

extension String {
    
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

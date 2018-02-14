//
//  String+DateFormat.swift
//  ios-simple-chat-demo
//
//  Created by Eiji Kushida on 2017/06/20.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

extension String {

    func toDateStyleMedium(dateFormat: String) -> Date  {

        let format = DateFormatter()
        format.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        format.timeStyle = .medium
        format.dateStyle = .medium
        format.dateFormat = dateFormat

        return format.date(from: self)!
    }
    
}

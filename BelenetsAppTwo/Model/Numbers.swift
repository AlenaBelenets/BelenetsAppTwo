//
//  Numbers.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 14.10.2023.
//

import Foundation

enum Constants {
    static let dateFormat = "EEEE HH:mm"
}

class Helpers {
    static let shared = Helpers()
    private lazy var dateFormatter = DateFormatter()

    func getCurrentDate(_ date: Int) -> String {
        let unixTimestamp = Double(date)
        let date = Date(timeIntervalSince1970: unixTimestamp)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = Constants.dateFormat
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

enum Numbers: Double {
    case one = 1.0
    case onePointFive = 1.5
    case two = 2.0
    case five = 5.0
    case seven = 7.0
    case ten = 10.0
    case twelve = 12.0
    case twenty = 20.0
    case twentyFour = 24.0
    case twentyFive = 25.0
    case thirty = 30.0
    case forty = 40.0
    case fifty = 50.0
    case seventy = 70.0
    case eighty = 80.0
    case ninety = 90.0
    case oneHundred = 100.0
    case oneHundredAndTen = 110.0
    case oneHundredAndTwenty = 120.0
    case oneHundredAndForty = 140.0
    case oneHundredAndFifty = 150.0
    case oneHundredAndEight = 180.0
    case twoHundred = 200.0
    case twoHundredAndSeventy = 270.0
    case threeHundred = 300.0
    case threeHundredAndEight = 380.0
    case fourHundred = 400.0
    case sixHundred = 600.0
    case sevenHundred = 700.0
    case sevenHundredAndFifty = 750.0
    case eightHundred = 800.0
}

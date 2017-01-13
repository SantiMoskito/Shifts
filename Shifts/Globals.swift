//
//  Constants.swift
//  Shifts
//
//  Created by Santiago Pérez Martínez on 10/12/16.
//  Copyright © 2016 Santiago Pérez Martínez. All rights reserved.
//

import Foundation
import UIKit

var currentCalendar = Calendar.current

////WARNING: REMOVE AFTER TESTING AND calendarCollectionViewContro
let testLocale = Locale(identifier: "es_ES") //ja_JP en_US es_ES ar_SA ne he_IL zh zh_Hant
let testCalendarIdentifier : Calendar.Identifier = .gregorian  //.japanese .gregorian .islamicUmmAlQura .buddhist .hebrew .chinese
////

let currentDate = Date()

var currentDateComponents = currentCalendar.dateComponents([.day,.month,.year,.weekday,.weekdayOrdinal], from: currentDate)

//let formatterMonthYear = DateFormatter()
//formatterMonthYear.dateFormat = "MM.yy"
let formatter = DateFormatter()

let oneDay = TimeInterval(60 * 60 * 24)

let darkerGrey  = UIColor(white: 0.4, alpha: 1)
let lighterGrey = UIColor(white: 0.8, alpha: 1)
let dayRed = #colorLiteral(red: 0.6038824556, green: 0.29627498, blue: 0.2957891252, alpha: 1)
let almostBlack = #colorLiteral(red: 0.1704671637, green: 0.1704671637, blue: 0.1704671637, alpha: 1)
let faintGrey = #colorLiteral(red: 0.963971288, green: 0.963971288, blue: 0.963971288, alpha: 1)
let testBlueDayColor = #colorLiteral(red: 0.2034428208, green: 0.8266380439, blue: 0.9454185101, alpha: 1)
let testBlueAfternoonColor = #colorLiteral(red: 0.3995158196, green: 0.6726317138, blue: 1, alpha: 1)
let testBlueNightColor = #colorLiteral(red: 0.5974707517, green: 0.5573524244, blue: 0.8660031582, alpha: 1)
let testGreenFreeColor = #colorLiteral(red: 0.6859629477, green: 0.9813225865, blue: 0.5182050888, alpha: 1)
let testGreenHolidayColor = #colorLiteral(red: 0.9244589127, green: 1, blue: 0.6209119537, alpha: 1)

let testGreenDefaultColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)

enum Shift {
    case day, afternoon, night, free, holiday
    //TODO: personalized shift type and color
}



//print("\(DateComponents(day:1,year:selectedDateComponents.year,month:selectedDateComponents.month))")
// MARK: - Global Func
//
//func dateComponents(_ calendar:Calendar?=currentCalendar,
//                    _ timeZone:TimeZone?=currentCalendar.timeZone,
//                    _ era:Int?=nil,
//                    year:Int?=selectedDateComponents.year,
//                    month:Int?=selectedDateComponents.month,
//                    day:Int?=selectedDateComponents.day,
//                    _ hour:Int?=nil,
//                    _ minute:Int?=nil,
//                    _ second:Int?=nil,
//                    _ nanosecond:Int?=nil,
//                    _ weekday:Int?=nil,
//                    _ weekdayOrdinal:Int?=nil,
//                    _ quarter:Int?=nil,
//                    _ weekOfMonth:Int?=nil,
//                    _ weekOfYear:Int?=nil,
//                    _ yearForWeekOfYear:Int?=nil)->DateComponents{
//
//    return DateComponents(calendar: calendar,
//                   
//                   timeZone: timeZone,
//                   
//                   era: era,
//                   
//                   year: year,
//                   
//                   month: month,
//                   
//                   day: day,
//                   
//                   hour: hour,
//                   
//                   minute: minute,
//                   
//                   second: second,
//                   
//                   nanosecond: nanosecond,
//                   
//                   weekday: weekday,
//                   
//                   weekdayOrdinal: weekdayOrdinal,
//                   
//                   quarter: quarter,
//                   
//                   weekOfMonth: weekOfMonth,
//                   
//                   weekOfYear: weekOfYear,
//                   
//                   yearForWeekOfYear: yearForWeekOfYear)
//
//}





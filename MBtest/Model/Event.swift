//
//  Event.swift
//  MBtest
//
//  Created by Maxim Mitin on 6.10.23.
//

import Foundation

var eventList = [Event]()

class Event {
    var id: Int!
    var name: String!
    var date: Date!
    
    func eventsForDate(date: Date) -> [Event] {
        var daysEvents = [Event]()
        
        for event in eventList {
            if(event.date == date){
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
}

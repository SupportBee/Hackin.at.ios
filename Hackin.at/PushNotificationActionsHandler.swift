//
//  PushNotificationActionsHandler.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 23/03/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation

class PushNotificationActionsHandler {
    class func handle(identifier: String?, category: String?, data: PushNotificationData){
        //println("In actions handler")
        
        //if(identifier == nil){ return }
        //if(category == nil){ return }
        
        //println("Has id and cat. has login? \(data.login)")
        
        //if(!CurrentHacker.doesExist()){ return }
        //if(CurrentHacker.login != data.login){ return }
        
        //println("Has login")
        
        //let currentCategories = UIApplication.sharedApplication().currentUserNotificationSettings().categories.allObjects
        //let filteredCategories = currentCategories.filter({ obj in
        //    var cat = obj as UIUserNotificationCategory
        //    return(cat.identifier! == category!)
        //})
        //if(filteredCategories.isEmpty){ return }
        
        //let currentCategory = filteredCategories.first as? UIUserNotificationCategory
        //println(currentCategory!.actionsForContext(UIUserNotificationActionContext.Default))
    }
}
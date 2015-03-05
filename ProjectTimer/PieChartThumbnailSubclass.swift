//
//  PieChartThumbnailSubclass.swift
//  ProjectTimer
//
//  Created by xcode on 3/4/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class PieChartThumbnailSubclass: PieChartThumbnail {


    // CRUD

    class func getPieCharts() -> (NSArray){

        var fetchRequest = NSFetchRequest(entityName: "PieChartThumbnail")

        var err = NSErrorPointer()
        let pieCharts = getMOC().executeFetchRequest(fetchRequest, error: err)

        if err != nil {println("Error \(err)");}

        return pieCharts! as NSArray

    }

    class func addPieChart(#title:NSString){

        var pieC = NSEntityDescription.insertNewObjectForEntityForName("PieChartThumbnail", inManagedObjectContext: getMOC()) as PieChartThumbnail
        pieC.chartTitle = title
        pieC.snapshot = UIImage(named:"defaultPie.png")


        var err = NSErrorPointer()
        getMOC().save(err)

        if err != nil {println("Error \(err)");}

    }

    class func deletePieChart(){

    }

    class func editPieChart(){


    }

    // CD

    class func getMOC() -> NSManagedObjectContext{

        let AppDel = UIApplication.sharedApplication().delegate! as AppDelegate
        return AppDel.managedObjectContext!
        
    }
    
}

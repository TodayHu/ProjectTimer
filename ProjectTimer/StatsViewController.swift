//
//  StatsViewController.swift
//  ProjectTimer
//
//  Created by xcode on 3/5/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class StatsViewController: ChartAndLegendVC_Superclass {


        var selectedPieChart:PieChartThumbnail?

        @IBOutlet weak var defaultViewToShowIfNoData: UIView!


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        defaultViewToShowIfNoData.hidden = true

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.navigationItem.title = selectedPieChart?.chartTitle ?? "Statistics"

    }

    override func getThePieChartCategoriesYouWantToDisplay_OverrideHereIfSubclassing() -> (NSSet) {

        // get the selected pie chart and grab its categories
        selectedPieChart = PieChartThumbnailSubclass.getTheSelectedPieChart()

//        // the faults have not triggered, so still have old data
//        var err = NSErrorPointer()
//        selectedPieChart = PieChartCategoryWrapperSubclass.getMOC().existingObjectWithID(selectedPieChart!.objectID, error: err) as? PieChartThumbnail

        // this gives us a list of the charts categories for free
        if selectedPieChart == nil || selectedPieChart!.pieChartsCategoryWrappers == nil { return NSSet()}
        var listOfAllCatWrappers = selectedPieChart!.pieChartsCategoryWrappers as NSSet

        // unfortunately, we do not have a filtered list - we do not want to display the hidden cats
        // we have two options: a) requery the db  b) just filter it with a nested loop => we will do that

        // make list of items that are not hidden
        var itemsForDisplay = NSMutableSet()

        for item in listOfAllCatWrappers {

            let ourItem = item as PieChartCategoryWrapper
            if ourItem.notUsedInChart == false {

                itemsForDisplay.addObject(ourItem)

            }
        }

        return itemsForDisplay
        
    }
    
    override func noDataToDispalyInChart(){

        // if no data to display, can customize view here
        defaultViewToShowIfNoData.hidden = false

        // remove old pieChart and legend if necessary
        pieChartAndLegend?.pieChart?.removeFromSuperview()
        pieChartAndLegend?.table?.removeFromSuperview()

        if pieChartAndLegend?.pieChart != nil {

            pieChartAndLegend?.pieChart = nil
            pieChartAndLegend?.table = nil

        }

    }

    override func viewWillDisappear(animated: Bool) {

        // save thumb of chart
        if selectedPieChart != nil {

            addSnapShotOfChartToPieChartThumbObject(selectedPieChart!)

            var err = NSErrorPointer()
            PieChartThumbnailSubclass.getMOC().save(err)

        }

        // call superclass viewWillDisappear
        super.viewWillDisappear(animated)

    }
}

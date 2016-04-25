//
//  InterfaceController.m
//  ComplicationCrash WatchKit Extension
//
//  Created by Daniel Morgan on 4/25/16.
//  Copyright © 2016 Daniel Morgan. All rights reserved.
//

#import "InterfaceController.h"
#import <ClockKit/ClockKit.h>

@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (IBAction)complicationForceLoad {
    CLKComplicationServer *complicationServer = [CLKComplicationServer sharedInstance];
    for (CLKComplication *complication in complicationServer.activeComplications) {
        [complicationServer reloadTimelineForComplication:complication];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




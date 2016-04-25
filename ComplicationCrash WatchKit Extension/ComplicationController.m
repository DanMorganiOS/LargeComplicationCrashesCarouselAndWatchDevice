//
//  ComplicationController.m
//  ComplicationCrash WatchKit Extension
//
//  Created by Daniel Morgan on 4/25/16.
//  Copyright © 2016 Daniel Morgan. All rights reserved.
//

#import "ComplicationController.h"

#define kComplicationRefreshRate 60*60 // minutes*numberOfSecondsInAMinute, so 60 mins - every hour

@interface ComplicationController ()
@end

@implementation ComplicationController

#pragma mark - Bug Section

- (NSString *)formattedStringThatWILLCrash {
    return @"55 SEC SEC SEC";
}

- (NSString *)formattedStringThatDoesNOTCrash {
    return @"55 SEC";
}

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    
    /**
     *  This is the line you need to change! The following methods are right above lines 38 and 42.
     */
    NSString* formattedString = [self formattedStringThatWILLCrash]; // will crash
//        NSString* formattedString = [self formattedStringThatDoesNOTCrash]; // will not crash
    
    NSString *waveHeightString = (formattedString) ?: @"-";
    NSString *locationNameString = (formattedString) ?: @"-";
    NSString *periodString = (formattedString) ?: @"-";
    NSString *unitsString = @"m";
    CLKComplicationTemplate *template = [[CLKComplicationTemplate alloc] init];
    switch (complication.family) {
            
            /**
             *  CLKComplicationFamilyModularLarge is the scenario where the crash occurs
             */
            
        case CLKComplicationFamilyModularLarge:
        {
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate.headerTextProvider = [CLKTextProvider textProviderWithFormat:@"%@", locationNameString];
            modLargeTemplate.body1TextProvider = [CLKTextProvider textProviderWithFormat:@"Height: %@%@", waveHeightString, unitsString];
            modLargeTemplate.body2TextProvider = [CLKTextProvider textProviderWithFormat:@"Period: %@", periodString];
            template = modLargeTemplate;
        }
            break;
            
        case CLKComplicationFamilyModularSmall:
        {
            CLKComplicationTemplateModularSmallStackText *modSmallTemplate = [[CLKComplicationTemplateModularSmallStackText alloc] init];
            modSmallTemplate.line1TextProvider = [CLKTextProvider textProviderWithFormat:@"%@", waveHeightString];
            modSmallTemplate.line2TextProvider = [CLKTextProvider textProviderWithFormat:@"%@", unitsString];
            template = modSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyCircularSmall:
        {
            CLKComplicationTemplateCircularSmallStackText *circleSmallTemplate = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
            circleSmallTemplate.line1TextProvider = [CLKTextProvider textProviderWithFormat:@"%@", waveHeightString];
            circleSmallTemplate.line2TextProvider = [CLKTextProvider textProviderWithFormat:@"%@", unitsString];
            template = circleSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyUtilitarianSmall:
        {
            CLKComplicationTemplateUtilitarianSmallFlat *utilSmallTemplate = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
            utilSmallTemplate.textProvider = [CLKTextProvider textProviderWithFormat:@"%@%@", waveHeightString, unitsString];
            template = utilSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyUtilitarianLarge:
        {
            CLKComplicationTemplateUtilitarianLargeFlat *utilLargeTemplate = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
            utilLargeTemplate.textProvider = [CLKTextProvider textProviderWithFormat:@"%@%@", waveHeightString, unitsString];
            template = utilLargeTemplate;
        }
            break;
    }
    CLKComplicationTimelineEntry *timelineEntry = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:template];
    handler(timelineEntry);
}

#pragma mark - Everything else, mostly stock except for refresh rate.

#pragma mark - Timeline Configuration

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionNone);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries after to the given date
    handler(nil);
}

#pragma mark Update Scheduling

- (void)getNextRequestedUpdateDateWithHandler:(void(^)(NSDate * __nullable updateDate))handler {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler([NSDate dateWithTimeIntervalSinceNow:kComplicationRefreshRate]);
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    CLKComplicationTemplate *template = [[CLKComplicationTemplate alloc] init];
    switch (complication.family) {
        case CLKComplicationFamilyModularSmall:
        {
            CLKComplicationTemplateModularSmallStackText *modSmallTemplate = [[CLKComplicationTemplateModularSmallStackText alloc] init];
            modSmallTemplate.line1TextProvider = [CLKTextProvider textProviderWithFormat:@"-"];
            modSmallTemplate.line2TextProvider = [CLKTextProvider textProviderWithFormat:@"ft"];
            template = modSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyCircularSmall:
        {
            CLKComplicationTemplateCircularSmallStackText *circleSmallTemplate = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
            circleSmallTemplate.line1TextProvider = [CLKTextProvider textProviderWithFormat:@"-"];
            circleSmallTemplate.line2TextProvider = [CLKTextProvider textProviderWithFormat:@"ft"];
            template = circleSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyUtilitarianSmall:
        {
            CLKComplicationTemplateUtilitarianSmallFlat *utilSmallTemplate = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
            utilSmallTemplate.textProvider = [CLKTextProvider textProviderWithFormat:@"-ft"];
            template = utilSmallTemplate;
        }
            break;
            
        case CLKComplicationFamilyModularLarge:
        {
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate.headerTextProvider = [CLKTextProvider textProviderWithFormat:@"Location"];
            modLargeTemplate.body1TextProvider = [CLKTextProvider textProviderWithFormat:@"Wave Height"];
            modLargeTemplate.body2TextProvider = [CLKTextProvider textProviderWithFormat:@"Period"];
            template = modLargeTemplate;
        }
            break;
            
        case CLKComplicationFamilyUtilitarianLarge:
        {
            CLKComplicationTemplateUtilitarianLargeFlat *utilLargeTemplate = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
            utilLargeTemplate.textProvider = [CLKTextProvider textProviderWithFormat:@"-ft"];
            template = utilLargeTemplate;
        }
            break;
    }
    handler(template);
}

@end

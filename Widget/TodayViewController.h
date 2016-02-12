//
//  TodayViewController.h
//  Widget
//
//  Created by Eduardo Oliveira on 09/02/16.
//  Copyright © 2016 knoker. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TodayViewController : NSViewController{
    NSMutableArray *nextEpisodes;
    NSMutableArray *shows;
    NSNumber *dateDelta;
}

@end

//
//  Cell.h
//  todayshows
//
//  Created by Eduardo Oliveira on 11/02/16.
//  Copyright © 2016 knoker. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Cell : NSTableCellView

@property (assign) IBOutlet NSTextField *episode;
@property (assign) IBOutlet NSTextField *date;

@end

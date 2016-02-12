//
//  TodayViewController.m
//  Widget
//
//  Created by Eduardo Oliveira on 09/02/16.
//  Copyright © 2016 knoker. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "Cell.h"
#import "iTVDb/iTVDb.h"


@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

-(void) viewDidLoad{

    [super viewDidLoad];
    dateDelta = [NSNumber numberWithInt:14];
    nextEpisodes = [[NSMutableArray alloc] init];
    shows = [[NSMutableArray alloc] initWithObjects:
             [NSNumber numberWithInt:72108],
             [NSNumber numberWithInt:257655],
             [NSNumber numberWithInt:262407],
             [NSNumber numberWithInt:279121], nil];

    [[TVDbClient sharedInstance] setApiKey: @"584539B3AF1997E0"];

    for(NSNumber *showId in shows){

        TVDbShow *show = [TVDbShow findById:showId];

        NSMutableArray *episodes = show.episodes;
        NSDate *now = [NSDate date];

        NSLog(@"%lu", (unsigned long)[episodes count]);
        NSLog(@"%@",[now dateByAddingTimeInterval:60*60*24*([dateDelta intValue])]);
        for(TVDbEpisode *ep in episodes){
            if ([now compare:ep.premiereDate]== NSOrderedAscending &&
                [[now dateByAddingTimeInterval:60*60*24*([dateDelta intValue])] compare:ep.premiereDate] == NSOrderedDescending) {
                NSDictionary *episode = @{
                                          @"show":show.title,
                                          @"episode":ep.title,
                                          @"date":ep.premiereDate,
                                          @"imageUrl":show.poster
                                          };

                [nextEpisodes addObject:episode];
            }
        }

    }

    nextEpisodes = [nextEpisodes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = ((NSDictionary*)a)[@"date"];
        NSDate *second = ((NSDictionary*)b)[@"date"];
        return [first compare:second];
    }];

}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you

    completionHandler(NCUpdateResultNoData);
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    Cell *cell = [tableView makeViewWithIdentifier:@"MyCell" owner:self];

    cell.textField.stringValue = [nextEpisodes objectAtIndex:row][@"show"];
    cell.episode.stringValue = [nextEpisodes objectAtIndex:row][@"episode"];
    cell.date.stringValue = [nextEpisodes objectAtIndex:row][@"date"];
    cell.imageView.image = [[NSImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[nextEpisodes objectAtIndex:row][@"imageUrl"]]]];

    return cell;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [nextEpisodes count];
}

@end


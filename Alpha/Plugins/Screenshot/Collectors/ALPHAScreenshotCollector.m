//
//  ALPHAScreenshotCollector.m
//  Alpha
//
//  Created by Dal Rupnik on 05/06/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAFileManager.h"
#import "ALPHAScreenshotCollector.h"
#import "ALPHATableScreenModel.h"

NSString *const ALPHAScreenshotDataIdentifier = @"com.unifiedsense.alpha.data.screenshot";

@interface ALPHAScreenshotCollector ()

@property (nonatomic, copy) NSArray *screenshots;

@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end

@implementation ALPHAScreenshotCollector

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterFullStyle;
        _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    }
    
    return _dateFormatter;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addDataIdentifier:ALPHAScreenshotDataIdentifier];
    }
    
    return self;
}

- (void)loadScreenshots
{
    NSError* error;
    
    NSString *directory = [NSString stringWithFormat:@"%@Alpha/Screenshots", [[ALPHAFileManager sharedManager] documentsDirectory].absoluteString];
    self.screenshots = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL URLWithString:directory] includingPropertiesForKeys:@[] options:0 error:&error];
}

- (ALPHAModel *)model
{
    [self loadScreenshots];
    
    ALPHATableScreenModel* screenModel = [[ALPHATableScreenModel alloc] initWithIdentifier:ALPHAScreenshotDataIdentifier];
    screenModel.title = @"Screenshots";
    
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSMutableArray* items = [NSMutableArray array];
    
    for (NSURL* screenshot in self.screenshots)
    {
        ALPHAScreenItem* item = [[ALPHAScreenItem alloc] init];
        item.title = [self titleForScreenshot:screenshot];
        item.file = screenshot;
        item.fileClass = [UIImage class];

        [items addObject:item];
    }
    
    section.items = items;
    
    screenModel.sections = @[ section ];
    
    return screenModel;
}

- (NSString *)titleForScreenshot:(NSURL *)screenshot
{
    NSString* filename = [screenshot.pathComponents lastObject];
    
    filename = [filename stringByReplacingOccurrencesOfString:@"ALPHA_SS_" withString:@""];
    filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@""];
    
    NSDate *date = [[ALPHAFileManager sharedManager].fileDateFormatter dateFromString:filename];
    
    NSString *text = [self.dateFormatter stringFromDate:date];
    
    if (!text.length)
    {
        text = [screenshot.pathComponents lastObject];
    }
    
    return text;
}

@end

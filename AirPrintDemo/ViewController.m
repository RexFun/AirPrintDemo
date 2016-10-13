//
//  ViewController.m
//  AirPrintDemo
//
//  Created by mac373 on 16/9/26.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton* printBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [printBtn setBackgroundColor:[UIColor whiteColor]];
    [printBtn setTitle:@"airprint" forState:UIControlStateNormal];
    [printBtn addTarget:self action:@selector(printTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printBtn];
    printBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:printBtn
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0
                                                           constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:printBtn
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0
                                                           constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:printBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:printBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:50]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printTap:(id)sender
{
    NSLog(@"test print");
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    UIMarkupTextPrintFormatter *formatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:@"<button>test</button>"];
    formatter.perPageContentInsets = UIEdgeInsetsMake(1 * 0.75f,  // 3/4 inch top margin
                                                      1 * 0.75f,  // 3/4 inch left margin
                                                      1 * 0.75f,  // 3/4 inch bottom margin
                                                      1 * 0.75f); // 3/4 inch right margin
    UIMarkupTextPrintFormatter *formatter1 = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:@"hello world"];
    formatter.perPageContentInsets = UIEdgeInsetsMake(1 * 0.75f,  // 3/4 inch top margin
                                                      1 * 0.75f,  // 3/4 inch left margin
                                                      1 * 0.75f,  // 3/4 inch bottom margin
                                                      1 * 0.75f); // 3/4 inch right margin
    
    UIPrintPageRenderer *ppr = [[UIPrintPageRenderer alloc] init];
    [ppr addPrintFormatter:formatter startingAtPageAtIndex:0];
    [ppr addPrintFormatter:formatter1 startingAtPageAtIndex:1];
    
//    controller.printFormatter = formatter;
    controller.printPageRenderer = ppr;
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName    = @"Job Name";
    controller.printInfo = printInfo;
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
//        self.content = nil;
        if (!completed && error)
            NSLog(@"FAILED! due to error in domain %@ with error code %u",
                  error.domain, error.code);
    };
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [controller presentFromBarButtonItem:sender animated:YES
                    completionHandler:completionHandler];
    } else {
        [controller presentAnimated:YES completionHandler:completionHandler];
    }
}

@end

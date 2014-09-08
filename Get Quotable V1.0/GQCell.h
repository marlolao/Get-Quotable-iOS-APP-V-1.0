//
//  GQCell.h
//  Get Quotable V1.0
//
//  Created by Marlo la O' on 9/5/14.
//  Copyright (c) 2014 Quotable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

//
//  GQViewController.m
//  Get Quotable V1.0
//
//  Created by Marlo la O' on 9/5/14.
//  Copyright (c) 2014 Quotable. All rights reserved.
//

#import "GQViewController.h"
#import "GQCell.h"

@interface GQViewController()<NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSMutableDictionary *getQuotes;
@property (nonatomic, copy) NSArray *jsonObject;

@end

@implementation GQViewController

// override this method to create NSURLSession Object
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        // set title
        self.navigationItem.title = @"UserName";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        
        [self fetchFeed];
    }
    
    return self;
}

// create a NSURLRequest to connect to getquotable.io and fetch user quotes
- (void)fetchFeed
{
    //NSString *requestString = @"http://getquotable.io/p/api/quotable/53f49addfc9fee305e3588dd";
    
    NSString *requestString = @"http://getquotable.io/api/feed";
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^
                                                         {
                                                             [self.tableView reloadData];
                                                         }
                                                         );
                                      }
                                      ];
    
    [dataTask resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create the NIB file
    UINib *nibFile = [UINib nibWithNibName:@"GQCell" bundle:nil];
    
    //register NIB file to tableView
    [self.tableView registerNib:nibFile forCellReuseIdentifier:@"GQCell"];

}

#pragma mark - UITableViewDelegate Protocol Methods

// get the number or rows to be return form the jsonObject
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jsonObject count];
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GQCell *cellRow = [tableView dequeueReusableCellWithIdentifier:@"GQCell" forIndexPath:indexPath];
    
    //cellRow.textLabel.text = self.jsonObject[@"title"];
    //cellRow.urlLabel.text = self.jsonObject[@"url"];
    //cellRow.datpo slef.eLabel.text = self.jsonObject[@"createdAt"];
    
    return cellRow;
}

#pragma mark - NSURLSessionDataDelegate Protocol Methods

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"test" password:@"test" persistence:NSURLCredentialPersistenceForSession];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end

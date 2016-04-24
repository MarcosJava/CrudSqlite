//
//  ViewController.h
//  CRUDSqlite
//
//  Created by Marcos Felipe Souza on 18/10/15.
//  Copyright © 2015 Marcos Felipe Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

- (IBAction)save:(id)sender;
- (IBAction)find:(id)sender;

@property NSString *databasePath;
@property sqlite3 *db;



@end


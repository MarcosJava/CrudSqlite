//
//  ClientesViewController.h
//  CRUDSqlite
//
//  Created by Marcos Felipe Souza on 20/10/15.
//  Copyright © 2015 Marcos Felipe Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ClientesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property NSArray *lista;

@property NSString *databasePath;
@property sqlite3 *db;

@end

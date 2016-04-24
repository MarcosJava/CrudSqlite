//
//  ClientesViewController.m
//  CRUDSqlite
//
//  Created by Marcos Felipe Souza on 20/10/15.
//  Copyright © 2015 Marcos Felipe Souza. All rights reserved.
//

#import "ClientesViewController.h"


@interface ClientesViewController ()

@end

@implementation ClientesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //Custom Inicialization
    }
    return self;
}
//.mode column
//.header on

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _lista = [[NSArray alloc] initWithObjects:@"Rafael",@"Marcos",@"Taiana", nil];
    NSLog(@"aqui");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//RETORNA A QUANTIDADE DE LINHA DA CELULA NA TABLEVIEW
- (NSInteger)tableView:(UITableView *)tableView
            numberOfRowsInSection:(NSInteger)section{
    
    return [_lista count];
}


//
- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celula"];
    
    // A posicao do momento, caso eu coloque o 0 ele ira me retornar apenas o primeiro
    cell.textLabel.text =[_lista objectAtIndex:indexPath.row];
    return cell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

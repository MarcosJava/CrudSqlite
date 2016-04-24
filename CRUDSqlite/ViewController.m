//
//  ViewController.m
//  CRUDSqlite
//
//  Created by Marcos Felipe Souza on 18/10/15.
//  Copyright © 2015 Marcos Felipe Souza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *diretorioPaths;
    NSString *dir;
    
    diretorioPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    dir = [diretorioPaths objectAtIndex:0]; //Pega o diretorio da aplicacao para salvar o SQLite
    
    //Pegando o nome do diretorio e concatenando com o nome do banco rlsistem.db
    _databasePath = [[NSString alloc] initWithString:[dir stringByAppendingPathComponent:@"rlsistem.db"]];
    
    //Verificando se o banco de dados ja existe
    NSFileManager *file = [NSFileManager defaultManager];
    if([file fileExistsAtPath:_databasePath] == NO){
        const char *dbPath = [_databasePath UTF8String];
        
        if(sqlite3_open(dbPath, &_db) == SQLITE_OK){
            
            char *erro_msg;
            
            const char *sql_stm = "CREATE TABLE IF NOT EXISTS clientes(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT)";
            
            if(sqlite3_exec(_db, sql_stm, NULL, NULL, &erro_msg) == SQLITE_OK){
                NSLog(@"Sucesso");
            } else {
                NSLog(@"Erro");
            }
            
            sqlite3_close(_db);
            
        }
    }
    
    
    
    NSLog(@"%@", dir);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    const char *dbPath = [_databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &_db) == SQLITE_OK){

        
        NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO clientes(nome, email) VALUES (\"%@\",\"%@\")",
                                _txtNome.text ,
                                _txtEmail.text];
        
        const char *sql_insert = [sqlInsert UTF8String];
        
        sqlite3_stmt *sql_stm;
        
        //Preparo o comando e coloco no slq_stm ( statement )
        sqlite3_prepare_v2(_db, sql_insert, -1, &sql_stm, NULL);
        
        
        //Caso for verdadeiro, ele inseriu o valor
        if(sqlite3_step(sql_stm) == SQLITE_DONE){
            _txtNome.text = @"";
            _txtEmail.text = @"";
            
            UIAlertView *alertView =[[ UIAlertView alloc]
                                        initWithTitle:@"Sucesso"
                                        message:@"Cadastro Realizado"
                                        delegate:self
                                        cancelButtonTitle:@"Não"
                                        otherButtonTitles:@"SIM", nil];
            [alertView show];
        }
        
        sqlite3_finalize(sql_stm); //Finaliza o Statement
        sqlite3_close(_db); // Finaliza a conexao
        
    }
}

- (IBAction)find:(id)sender {
    const char *dbPath = [_databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &_db) == SQLITE_OK){

        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM clientes WHERE nome =\"%@\"",
                               _txtNome.text];
        
        const char *sql_query  = [sqlQuery UTF8String];
        
        sqlite3_stmt *sql_stm;
        
        sqlite3_prepare_v2(_db, sql_query, -1, &sql_stm, NULL);
        
        if(sqlite3_step(sql_stm) == SQLITE_ROW){
           
            //Transformando a consulta em string e pegando a primeira linha.
            NSString *nome =[[NSString alloc] initWithUTF8String:
                             (const char *) sqlite3_column_text(sql_stm, 1)];
            
            NSString *email =[[NSString alloc] initWithUTF8String:
                             (const char *) sqlite3_column_text(sql_stm, 2)];
            
            _txtNome.text = nome;
            _txtEmail.text = email;
        }
        
        
        sqlite3_finalize(sql_stm); //Finaliza o Statement
        sqlite3_close(_db); // Finaliza a conexao
        
    }

    
}
@end

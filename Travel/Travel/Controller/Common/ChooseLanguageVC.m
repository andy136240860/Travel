//
//  ChooseLanguageVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "ChooseLanguageVC.h"

@interface ChooseLanguageVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseLanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedLanguage = [NSMutableArray arrayWithCapacity:3];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.selectedLanguage.count) {
//        for (NSString *language in self.selectedLanguage) {
//            
//        }
//    }
}

- (void)loadContentView {
    _tableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.contentView addSubview:_tableView];
    
    for (int i = 0 ; i < [NSLocale ISOLanguageCodes].count; i++) {
        NSLog(@"%@ , \t %@", [NSLocale ISOLanguageCodes][i],[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[NSLocale ISOLanguageCodes][i]]);
    }
}

#pragma mark - TableViewDataSourece & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [NSLocale ISOLanguageCodes].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"defaultCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [self.selectedLanguage containsObject:[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[NSLocale ISOLanguageCodes][indexPath.row]]];
    cell.textLabel.text = [NSLocale ISOLanguageCodes][indexPath.row],[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[NSLocale ISOLanguageCodes][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

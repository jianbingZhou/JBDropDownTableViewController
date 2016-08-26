//
//  JBDropDownTableViewController.m
//  JBDropDownTableViewController
//
//  Created by Terra MacBook on 16/8/26.
//  Copyright © 2016年 JianbingZhou. All rights reserved.
//

#import "JBDropDownTableViewController.h"
#import "SDAttachCell.h"

@interface JBDropDownTableViewController ()

@end

@implementation JBDropDownTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellDataSourceArray=[[NSMutableArray alloc]initWithCapacity:0];
    _dicDataArray=[[NSMutableArray alloc]initWithCapacity:0];
    _cellDataSourceArray=[[NSMutableArray alloc]initWithObjects:@"z",@"j",@"b",@"drop",@"down",@"cell",@"z",@"j",@"b",@"drop",@"down",@"cell",nil];
    NSDictionary *dic=@{@"cellType":@"customCell",@"isDropDowned":@(NO)};

    //用一个容量与_cellDataSourceArray相同的数组 纪录下拉与回收（单元格的增加或减少）
    for (NSInteger i=0; i<_cellDataSourceArray.count; i++) {
        [_dicDataArray addObject:dic];
    }

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dicDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_dicDataArray[indexPath.row] objectForKey:@"cellType"] isEqualToString:@"attachCell"]) {
        
        
        return 50;
    }
    else if ([[_dicDataArray[indexPath.row] objectForKey:@"cellType"] isEqualToString:@"customCell"]){
        
        
        return 80;
    }else {
        return 0;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *aIndexPath = nil;
    if ([[_dicDataArray[indexPath.row] objectForKey:@"cellType"] isEqualToString:@"customCell"]) {
        aIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    }else {
        aIndexPath = indexPath;
    }
    
    if (![[_dicDataArray[indexPath.row] objectForKey:@"isDropDowned"] boolValue]) {
        NSDictionary *customCellDic = @{@"cellType":@"customCell",@"isDropDowned":@(YES)};
        _dicDataArray[aIndexPath.row - 1] = customCellDic;
        NSDictionary *attachCellDic = @{@"cellType":@"attachCell",@"isDropDowned":@(YES)};
        [_dicDataArray insertObject:attachCellDic atIndex:aIndexPath.row];
        [_cellDataSourceArray insertObject:attachCellDic atIndex:aIndexPath.row];//加入一个无用的数据字典 占个位置
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[aIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }else {
        NSDictionary *customCellDic = @{@"cellType":@"customCell",@"isDropDowned":@(NO)};
        _dicDataArray[aIndexPath.row - 1] = customCellDic;
        
        [_dicDataArray removeObjectAtIndex:aIndexPath.row];
        [_cellDataSourceArray removeObjectAtIndex:aIndexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[aIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [_dicDataArray objectAtIndex:indexPath.row];
    NSString *str = [dic objectForKey:@"cellType"];
    if ([str isEqualToString:@"customCell"]) {
        static NSString *cellID=@"customCell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text=_cellDataSourceArray[indexPath.row];
        return cell;
    }
    else if([str isEqualToString:@"attachCell"]){
        static NSString *cellID=@"attachCell";
        SDAttachCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[SDAttachCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;

}

@end

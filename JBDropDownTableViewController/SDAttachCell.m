//
//  SCXAttachCell.m
//  书生网盘
//
//  Created by 孙承秀 on 15/12/27.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SDAttachCell.h"
//#import <Masonry.h>
static SDAttachCell *attachCell=nil;
@implementation SDAttachCell
+(SDAttachCell *)sharedAttachCell{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        attachCell=[[SDAttachCell allocWithZone:NULL]init];
    });
    return attachCell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //每个按钮的宽度
        CGFloat width=([UIScreen mainScreen].bounds.size.width)/9;
        UIButton *b1=[[UIButton alloc]init];
        b1.tag=1;
        [self setUpButton:b1 withTitle:@"下载"];
        //下载按钮
        [b1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        //分享按钮
        UIButton *b2=[[UIButton alloc]init];
        b2.tag=2;
        [self setUpButton:b2 withTitle:@"分享"];
        [b2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        //删除按钮
        UIButton *b3=[[UIButton alloc]init];
        b3.tag=3;
        [self setUpButton:b3 withTitle:@"删除"];
        [b3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        //更多按钮
        UIButton *b4=[[UIButton alloc]init];
        b4.tag=4;
        [self setUpButton:b4 withTitle:@"更多"];
        [b4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:b1];
        [self.contentView addSubview:b2];
        [self.contentView addSubview:b3];
        [self.contentView addSubview:b4];
        //适配
        NSArray *arr=[[NSArray alloc]initWithObjects:b1,b2,b3,b4, nil];
        for (NSInteger i=0; i<4; i++) {
            [arr[i] setFrame:CGRectMake(width*(2*i+1), 5, width, 40)];
        }
        
    }
    return self;
}

#pragma mark-- 设置button样式
-(void)setUpButton:(UIButton *)button withTitle:(NSString *)title{
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button setTitle:title forState:UIControlStateNormal];

}
#pragma mark--按钮点击事件  
-(void)btnAction:(id)sender{

    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xiazai" object:nil];
            NSLog(@"点击下载了");
        }
            break;
        case 2:
        {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"fenxiang" object:[btn currentTitle]];
             NSLog(@"点击分享了");
        }
            break;
        case 3:
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"shanchu" object:nil];
             NSLog(@"点击删除了");
        }
            break;
        case 4:
        {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gengduo" object:[btn titleForState:UIControlStateNormal] ];
             NSLog(@"点击更多了");
        }
            break;
        default:
            break;
    }
}
@end

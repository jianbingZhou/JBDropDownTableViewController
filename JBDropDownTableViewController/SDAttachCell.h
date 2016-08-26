//
//  SCXAttachCell.h
//  书生网盘
//
//  Created by 孙承秀 on 15/12/27.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAttachCell : UITableViewCell
@property(nonatomic,strong)UIButton *b1;
@property(nonatomic,strong)UIButton *b2;
@property(nonatomic,strong)UIButton *b3;
@property(nonatomic,strong)UIButton *b4;
@property(nonatomic,strong)UIButton *b5;
@property(nonatomic,assign)CGFloat width;
+(SDAttachCell *)sharedAttachCell;
@end

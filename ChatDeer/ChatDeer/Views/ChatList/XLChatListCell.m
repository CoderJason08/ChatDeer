//
//  XLChatListCell.m
//  ChatDeer
//
//  Created by Jason on 16/3/30.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLChatListCell.h"

@interface XLChatListCell ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
//@property (nonatomic, strong) UIButton *deleteButton;
//@property (nonatomic, strong) UIButton *donotRemindButton;
@end

@implementation XLChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViewsConstraints];
        self.backgroundColor = LightGrayColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Private Func

- (void)setConversation:(AVIMConversation *)conversation {
    _conversation = conversation;
    _titleLabel.text = conversation.name;
    _dateLabel.text = [XLDateFormatter dateStrWithDate:conversation.lastMessageAt];
}

//- (void)swipeGestureRecognizerTrigger:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
//    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
//        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 155));
//        }];
//    }
//}

- (void)setupSubViewsConstraints {
    
//    __weak typeof(self) self = self;
    
//    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.containerView);
//        make.right.equalTo(self).offset(-10);
//        make.width.mas_equalTo(50);
//    }];
//    
//    [self.donotRemindButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.containerView);
//        make.right.equalTo(self).offset(-10);
//        make.width.mas_equalTo(100);
//    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.containerView).offset(5);
        make.bottom.equalTo(self.containerView).offset(-5);
        make.width.equalTo(self.iconImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.iconImageView).offset(3);
        make.right.equalTo(self.dateLabel.mas_left).offset(-5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.offset(-5);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.offset(-5);
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        self.containerView = [UIView new];
        [self.contentView addSubview:_containerView];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 5.0f;
//        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerTrigger:)];
//        [_containerView addGestureRecognizer:swipeGestureRecognizer];
    }
    return _containerView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        self.iconImageView = [UIImageView new];
        [self.containerView addSubview:_iconImageView];
        _iconImageView.backgroundColor = GrayColor;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [UILabel new];
        [self.containerView addSubview:_titleLabel];
        _titleLabel.textColor = BlackColor;
        _titleLabel.font = BoldFont(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"this is a test title";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [UILabel new];
        [self.containerView addSubview:_contentLabel];
        _contentLabel.textColor = GrayColor;
        _contentLabel.font = Font(12);
        _contentLabel.text = @"this is a test content";
    }
    return _contentLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        self.dateLabel = [UILabel new];
        [self.containerView addSubview:_dateLabel];
        _dateLabel.textColor = LightGrayColor;
        _dateLabel.font = Font(11);
        _dateLabel.text = @"yy/MM/dd";
    }
    return _dateLabel;
}

//- (UIButton *)deleteButton {
//    if (!_deleteButton) {
//        _deleteButton = [UIButton new];
//        [self.contentView addSubview:_deleteButton];
//        _deleteButton.backgroundColor = [UIColor redColor];
//    }
//    return _deleteButton;
//}
//
//- (UIButton *)donotRemindButton {
//    if (!_donotRemindButton) {
//        _donotRemindButton = [UIButton new];
//        [self.contentView addSubview:_donotRemindButton];
//        _donotRemindButton.backgroundColor = [UIColor grayColor];
//    }
//    return _donotRemindButton;
//}

@end

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
@end

@implementation XLChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void)setConversation:(AVIMConversation *)conversation {
    _conversation = conversation;
    _titleLabel.text = conversation.name;
    _dateLabel.text = [XLDateFormatter dateStrWithDate:conversation.lastMessageAt];
}

- (void)setupSubViewsConstraints {
    __weak typeof(self) weakSelf = self;
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.containerView).offset(5);
        make.bottom.equalTo(weakSelf.containerView).offset(-5);
        make.width.equalTo(weakSelf.iconImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(5);
        make.top.equalTo(weakSelf.iconImageView).offset(3);
        make.right.equalTo(weakSelf.dateLabel.mas_left).offset(-5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        make.right.offset(-5);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.titleLabel);
        make.right.offset(-5);
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        self.containerView = [UIView new];
        [self.contentView addSubview:_containerView];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 5.0f;
//        _containerView.layer.borderColor = BlackColor.CGColor;
//        _containerView.layer.borderWidth = 1.0f;
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



@end

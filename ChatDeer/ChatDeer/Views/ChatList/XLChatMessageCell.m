//
//  XLChatMessageCell.m
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLChatMessageCell.h"

@interface XLChatMessageCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageBubble;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation XLChatMessageCell

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
//        [self setupSubViewsConstraints];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - setter

- (void)setImMessage:(AVIMMessage *)imMessage {
    _imMessage = imMessage;
    self.messageBubble.text = imMessage.content;
    /** 消息类型 */
    XLChatMessageCellType type = imMessage.ioType == AVIMMessageIOTypeIn ? XLChatMessageCellTypeOthers : XLChatMessageCellTypeMine;
    [self setupSubViewsConstraintsWithType:type];
    /** 发送时间 */
    self.timeLabel.text = [XLDateFormatter dateWithTimeStamp:imMessage.sendTimestamp];
    /** clientId */
    self.nameLabel.text = imMessage.clientId;
}

#pragma mark - Constraints

- (void)setupSubViewsConstraintsWithType:(XLChatMessageCellType)type {
    /** 时间 */
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(5);
    }];
    
    if (type == XLChatMessageCellTypeOthers) {
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(3);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(5);
            make.top.equalTo(self.iconImageView).offset(-2);
        }];
        self.messageBubble.textAlignment = NSTextAlignmentLeft;
        [self.messageBubble mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
            make.right.offset(-120);
            make.bottom.offset(-15);
        }];

    }else {
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(3);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iconImageView.mas_left).offset(-5);
            make.top.equalTo(self.iconImageView).offset(-2);
        }];
        self.messageBubble.textAlignment = NSTextAlignmentRight;
        [self.messageBubble mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
            make.left.offset(120);
            make.bottom.offset(-15);
        }];
    }
    
}

#pragma mark - Lazy getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.font = Font(12);
        _timeLabel.text = @"12:00";
    }
    return _timeLabel;
}

- (UILabel *)messageBubble {
    if (!_messageBubble) {
        self.messageBubble = [UILabel new];
        [self.contentView addSubview:_messageBubble];
        _messageBubble.font = Font(15);
        _messageBubble.numberOfLines = 0;
        [_messageBubble setText:@"this is a test message content, this is a test message content, this is a test message content, this is a test message content"];
    }
    return _messageBubble;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:_iconImageView];
        _iconImageView.image = [UIImage imageNamed:@"defaultUserIcon"];
        _iconImageView.layer.cornerRadius = 5.0;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = Font(12);
        _nameLabel.text = @"test name";
    }
    return _nameLabel;
}

@end

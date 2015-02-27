//
//  HTHorizontalSelectionListLabelCell.m
//  HTHorizontalSelectionList Example
//
//  Created by Erik Ackermann on 2/26/15.
//  Copyright (c) 2015 Hightower. All rights reserved.
//

#import "HTHorizontalSelectionListLabelCell.h"

@interface HTHorizontalSelectionListLabelCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableDictionary *titleColorsByState;

@end

@implementation HTHorizontalSelectionListLabelCell

@synthesize state = _state;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addSubview:_titleLabel];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|"
                                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];

        _titleColorsByState = [NSMutableDictionary dictionary];
        _titleColorsByState[@(UIControlStateNormal)] = [UIColor blackColor];

        _state = UIControlStateNormal;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.title = nil;
    self.titleColorsByState = [NSMutableDictionary dictionary];
    self.titleColorsByState[@(UIControlStateNormal)] = [UIColor blackColor];
    self.state = UIControlStateNormal;
}

#pragma mark - Public Methods

+ (CGSize)sizeForTitle:(NSString *)title {
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                                           context:nil];
    return CGSizeMake(titleRect.size.width + 20, titleRect.size.height);
}

#pragma mark - Custom Getters and Setters

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setState:(UIControlState)state {
    _state = state;

    [self updateTitleColor];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    self.titleColorsByState[@(state)] = color;

    [self updateTitleColor];
}

#pragma mark - Private Methods

- (void)updateTitleColor {
    self.titleLabel.textColor = self.titleColorsByState[@(self.state)];
}

@end

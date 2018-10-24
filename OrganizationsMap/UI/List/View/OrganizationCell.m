#import "OrganizationCell.h"
#import <Masonry.h>

@interface OrganizationCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@end

@implementation OrganizationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeViews];
        [self addSubviews];
        [self makeConstraints];
    }
    return self;
}

- (void)configureWith:(id)model {
    
}

- (void)makeViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    _titleLabel.numberOfLines = 1;
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descriptionLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    _descriptionLabel.numberOfLines = 1;
}

- (void)addSubviews {
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_descriptionLabel];
}

- (void)makeConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.leading.equalTo(self.contentView).offset(4);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel).offset(4);
        make.leading.equalTo(self.titleLabel);
    }];
}

@end

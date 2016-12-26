//
//  EditTravelTogetherTableViewCell.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/14.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "EditTravelTogetherTableViewCell.h"
#import "NSDate+SNExtension.h"
#import "JTCalendar.h"
#import "XWViewController.h"

@interface EditTravelTogetherTableViewBaseCell() {
    UIView *bgview;
    UIView *pickerView;
}

@end

@implementation EditTravelTogetherTableViewBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubView {
    CGFloat buttonWidth = 70;
    CGFloat buttonHeight = 44;
    bgview = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _contentPickerView = [self loadContentView];
    
    pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.frameHeight, bgview.frameWidth, _contentPickerView.frameHeight + buttonHeight)];
    pickerView.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:pickerView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0 , buttonHeight - kDefaultLineHeight, pickerView.frameWidth, kDefaultLineHeight)];
    lineView.backgroundColor = UIColorFromHex(0xee5e5e5);
    [pickerView addSubview:lineView];
    
    _contentPickerView.frameY = buttonHeight;
    [pickerView addSubview:_contentPickerView];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, buttonWidth, buttonHeight)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancellAction) forControlEvents:UIControlEventTouchUpInside];
    [pickerView addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(pickerView.frameWidth - 12 - buttonWidth, 0, buttonWidth, buttonHeight)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [pickerView addSubview:confirmButton];
}

- (void)tapAction {
    [[XWViewController currentViewController].view endEditing:YES];
    [self pickViewWillAppear];
    CGFloat pickerViewHeight = _contentPickerView.frameHeight + 44;
    CGFloat animationDuration = 0.3;
    bgview.alpha = 1;
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [[UIApplication sharedApplication].keyWindow addSubview:bgview];
    pickerView.frame = CGRectMake(0, bgview.frameHeight, bgview.frameWidth, pickerViewHeight);
    [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
    [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        pickerView.frame = CGRectMake(0, bgview.frameHeight - pickerViewHeight, bgview.frameWidth, pickerViewHeight);
    } completion:nil];
}

- (UIView *)loadContentView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    return view;
}

- (void)pickViewWillAppear{

}

- (void)cancellAction {
    [self closeView];
}

- (void)confirmAction {

}

- (void)closeView {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        bgview.alpha = 0;
    } completion:^(BOOL finished) {
        [bgview removeFromSuperview];
    }];
}

@end

@implementation EditTravelTogetherTableViewCell_0_0   //旅行目的地

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.text = @"旅行目的地";
        self.userInteractionEnabled = YES;

    }
    return self;
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
//    NSString *text = self.travelTogether.destination.latitude == 0  ? self.travelTogether.destination:@"未选择";
//    self.detailTextLabel.text = text;
}

@end

@interface EditTravelTogetherTableViewCell_0_1()<JTCalendarDelegate> {

}

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation EditTravelTogetherTableViewCell_0_1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textLabel.text = @"开始时间";
        
    }
    return self;
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    [super setTravelTogether:travelTogether];
    if (self.travelTogether.startTime == 0) {
        self.detailTextLabel.text = @"未选择";
    }
    else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.travelTogether.startTime];
        self.detailTextLabel.text = [date stringWithDateFormat:@"yyyy-MM-dd"];
    }
}

- (void)confirmAction {
    self.travelTogether.startTime = (NSInteger)_dateSelected.timeIntervalSince1970;
    [self closeView];
}

- (void)pickViewWillAppear {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.travelTogether.startTime];
    if ([date isLaterThanDate:[NSDate date]]) {
        _dateSelected = date;
        [_calendarManager setDate:_dateSelected];
    }
}

- (UIView *)loadContentView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 350)];
    _dateSelected = [NSDate date];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    _calendarManager.settings.zeroPaddedDayFormat = YES;
    
    _calendarMenuView = [[JTCalendarMenuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _calendarMenuView.backgroundColor = UIColorFromHex(0xffffff);
    _calendarContentView = [[JTHorizontalCalendarView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 300)];
    _calendarContentView.backgroundColor = [UIColor whiteColor];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_dateSelected];
    
    [view addSubview:_calendarMenuView];
    [view addSubview:_calendarContentView];
    return view;
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if (![dayView.date isLaterThanDate:[NSDate date]]) {
        return;
    }
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Views customization

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    
    return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy MM";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
    }
    
    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    
    view.circleRatio = .8;
    view.dotRatio = 1. / .9;
    
    return view;
}


@end

@implementation EditTravelTogetherTableViewCell_0_2

- (void)confirmAction {
    self.travelTogether.endTime = (NSInteger)self.dateSelected.timeIntervalSince1970;
    [self closeView];
}

- (void)pickViewWillAppear {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.travelTogether.endTime];
    if ([date isLaterThanDate:[NSDate date]]) {
        self.dateSelected = date;
        [self.calendarManager setDate:self.dateSelected];
    }
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    [super setTravelTogether:travelTogether];
    if (self.travelTogether.endTime == 0) {
        self.detailTextLabel.text = @"未选择";
    }
    else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.travelTogether.endTime];
        self.detailTextLabel.text = [date stringWithDateFormat:@"yyyy-MM-dd"];
    }
}

@end

@interface EditTravelTogetherTableViewCell_0_3()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *myPickerView;
@property (nonatomic, assign) NSInteger     selectedRow;
@property (nonatomic, strong) UISwitch      *mySwitch;

@end

@implementation EditTravelTogetherTableViewCell_0_3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textLabel.text = @"旅行人数";
        
    }
    return self;
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    [super setTravelTogether:travelTogether];
    if (self.travelTogether.peopleNumber == 0) {
        self.detailTextLabel.text = @"未选择";
    }
    else {
        if (self.travelTogether.peopleNumberCanExceed) {
            self.detailTextLabel.text = [NSString stringWithFormat:@"%d人或更多",self.travelTogether.peopleNumber];
        }
        else{
            self.detailTextLabel.text = [NSString stringWithFormat:@"%d人",self.travelTogether.peopleNumber];
        }
    }
}

- (void)confirmAction {
    self.travelTogether.peopleNumber = _selectedRow + 1;
    self.travelTogether.peopleNumberCanExceed = _mySwitch.on;
    [self closeView];
}

- (void)pickViewWillAppear {
    if (self.travelTogether.peopleNumber) {
        [_myPickerView selectRow:self.travelTogether.peopleNumber - 1 inComponent:0 animated:NO];
    }
    [_mySwitch setOn:self.travelTogether.peopleNumberCanExceed];
}

- (UIView *)loadContentView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2.f, view.frameHeight/2 - 17 - 8, kScreenWidth/2.f, 17)];
    label.text = @"人数可超";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    _mySwitch = [[UISwitch alloc]init];
    _mySwitch.frame = CGRectMake((kScreenWidth *3/4 - _mySwitch.frameWidth/2), view.frameHeight/2.f, _mySwitch.frameWidth, _mySwitch.frameHeight);
    [view addSubview:_mySwitch];
    
    _myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 200)];
    _myPickerView.delegate = self;
    [view addSubview:_myPickerView];
    return view;
}

#pragma mark - UIPickerViewDelegate&DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d",row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedRow = row;
}


@end

@interface EditTravelTogetherTableViewCell_0_4()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *myPickerView;
@property (nonatomic, assign) NSInteger     selectedRow;

@end

@implementation EditTravelTogetherTableViewCell_0_4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textLabel.text = @"交通状况";
        
    }
    return self;
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    [super setTravelTogether:travelTogether];
    if (self.travelTogether.peopleNumber == 0) {
        self.detailTextLabel.text = @"未选择";
    }
    else {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.travelTogether.peopleNumber];
    }
}

- (void)confirmAction {
    self.travelTogether.peopleNumber = _selectedRow + 1;
    [self closeView];
}

- (void)pickViewWillAppear {
    if (self.travelTogether.peopleNumber) {
        [_myPickerView selectRow:self.travelTogether.peopleNumber - 1 inComponent:0 animated:NO];
    }
}

- (UIView *)loadContentView {
    _myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _myPickerView.delegate = self;
    return _myPickerView;
}

#pragma mark - UIPickerViewDelegate&DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d",row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedRow = row;
}


@end

@implementation EditTravelTogetherTableViewCell_0_5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textLabel.text = @"语言支持";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    if (self.travelTogether.peopleNumber == 0) {
        self.detailTextLabel.text = @"未选择";
    }
    else {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.travelTogether.peopleNumber];
    }
}

@end

@implementation EditTravelTogetherTableViewCell_0_6

@end

@implementation EditTravelTogetherTableViewCell_0_7

@end

@implementation EditTravelTogetherTableViewCell_0_8

@end


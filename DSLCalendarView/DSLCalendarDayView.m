/*
 DSLCalendarDayView.h
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"


@interface DSLCalendarDayView ()

@property (nonatomic, strong) UIView *adjacentMonthView;
@property (nonatomic, strong) UIImageView *selectedView;
@property (nonatomic, strong) UILabel *label;

@end


@implementation DSLCalendarDayView


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        
        _adjacentMonthView = [[UIView alloc] initWithFrame:self.bounds];
        _adjacentMonthView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:_adjacentMonthView];
        
        _selectedView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_selectedView];

        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = UITextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return self;
}


#pragma mark - Properties

- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState {
    self.selectedView.hidden = NO;
    self.label.textColor = [UIColor whiteColor];

    switch (selectionState) {
        case DSLCalendarDayViewNotSelected:
            self.selectedView.hidden = YES;
            self.label.textColor = [UIColor blackColor];
            break;
            
        case DSLCalendarDayViewStartOfSelection:
            self.selectedView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
            break;
            
        case DSLCalendarDayViewEndOfSelection:
            self.selectedView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
            break;
            
        case DSLCalendarDayViewWithinSelection:
            self.selectedView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
            break;
            
        case DSLCalendarDayViewWholeSelection:
            self.selectedView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
            break;
    }
}

- (void)setDay:(NSDateComponents *)day {
    _day = [day copy];
    self.label.text = [NSString stringWithFormat:@"%d", day.day];
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    self.adjacentMonthView.alpha = inCurrentMonth ? 0.0 : 1.0;
}

@end

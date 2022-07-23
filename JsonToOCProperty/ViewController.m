//
//  ViewController.m
//  JsonToOCProperty
//
//  Created by Ken Choi on 26/7/2017.
//  Copyright © 2017 Ken Choi. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()
@property (weak) IBOutlet NSTextField *textField;
//@property (weak) IBOutlet NSTextView *resultTextView;
@property (weak) IBOutlet NSTextField *resultLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)resultBtnClick:(NSButton *)sender {
    
    NSDictionary * tempdic = [self dictionaryWithJsonString:_textField.stringValue];
//    NSDictionary * dic = [NSDictionary]
    NSLog(@"tempdic");
    if ([tempdic isKindOfClass:[NSDictionary class]]) {
        __block NSString * jsonText = @"";
        [tempdic enumerateKeysAndObjectsUsingBlock:^(NSString *   key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            jsonText = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString * %@;\n%@",key,jsonText];
            
        }];
     _resultLab.stringValue = jsonText;
        

    }
    else{
        NSAlert * alert = [NSAlert alertWithMessageText:@"It is wrong" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"the text is not full json str"];
        [alert runModal];
                           
        
    }
}


-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end

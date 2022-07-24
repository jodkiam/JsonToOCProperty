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
@property (weak) IBOutlet NSButton *choiceBtn;
@property (weak) IBOutlet NSTextField *paraTF;
@property (weak) IBOutlet NSTextField *paramNameTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.choiceBtn.state = NSControlStateValueMixed;
    // Do any additional setup after loading the view.
    self.paramNameTF.stringValue = @"pramas";
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
        
        if (self.choiceBtn.state) {
            [tempdic enumerateKeysAndObjectsUsingBlock:^(NSString *   key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                jsonText = [NSString stringWithFormat:@"%@ :(NSString *)%@ \n%@",key,key,jsonText];
                
            }];
            __block NSString * params = @"";
            [tempdic enumerateKeysAndObjectsUsingBlock:^(NSString *   key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                params = [NSString stringWithFormat:@"[%@ setObject:%@ forKey:""%@""]; \n%@",self.paramNameTF.stringValue,key,key,params];
                
            }];
            _paraTF.stringValue = params;

        }
        else
        {
            [tempdic enumerateKeysAndObjectsUsingBlock:^(NSString *   key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                jsonText = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString * %@;\n%@",key,jsonText];
                
            }];
        }
   
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
- (IBAction)choiceBtnAction:(NSButton*)sender {
//    sender.state = !sender.state;
}
@end

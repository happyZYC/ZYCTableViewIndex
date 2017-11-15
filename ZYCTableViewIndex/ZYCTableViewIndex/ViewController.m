

#import "ViewController.h"
#import "DSectionIndexItemView.h"
#import "DSectionIndexView.h"
#import "HMOffice.h"
@interface ViewController ()<DSectionIndexViewDelegate,DSectionIndexViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) DSectionIndexView *sectionIndexView;
@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSMutableDictionary *sectionDic;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *indexTitleArray;
@property (nonatomic,strong) NSMutableArray *letterArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (NSMutableArray *)indexTitleArray
{
    if (!_indexTitleArray) {
        _indexTitleArray = [NSMutableArray array];
    }
    return _indexTitleArray;
}
- (NSMutableArray *)letterArray
{
    if (!_letterArray) {
        _letterArray = [NSMutableArray array];
        for (char c = 'A'; c <= 'Z'; c++) // 大写字母
        {
            NSString *letter = [NSString stringWithFormat:@"%c", c];
            [_letterArray addObject:letter];
        }
    }
    return _letterArray;
}

#pragma mark - defalt

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = @[@{@"id":@"1",@"name":@"耳鼻喉科",@"describ":@"咽炎,中耳炎,鼻炎,鼻中隔偏曲"},@{@"id":@"2",@"name":@"放射科",@"describ":@" 内照射放射病,放射性局部损伤,急性放射性"},@{@"id":@"3",@"name":@"感染科",@"describ":@"艾滋病,性病,非典,梅毒"},@{@"id":@"4",@"name":@"心理疾病",@"describ":@"精神空虚,抑郁症,强迫症"},@{@"id":@"5",@"name":@"鼻科",@"describ":@"鼻窦炎,鼻甲肥大,鼻炎"},@{@"id":@"6",@"name":@"过敏类疾病",@"describ":@"花粉过敏,粉尘过敏"},@{@"id":@"7",@"name":@"脑血管疾病",@"describ":@"脑出血,脑干出血"},@{@"id":@"8",@"name":@"呼吸科",@"describ":@"肺粘膜粘连,支气管扩张"},@{@"id":@"9",@"name":@"疾病",@"describ":@"脑血管疾病,传染类疾病"},@{@"id":@"10",@"name":@"癌症",@"describ":@"肺癌,血管e癌,乳腺癌"},@{@"id":@"11",@"name":@"肺部疾病",@"describ":@"肺大泡,肺粘膜粘连,肺炎"},@{@"id":@"12",@"name":@"不孕不育科",@"describ":@"精子火星不足,卵巢囊肿"},@{@"id":@"13",@"name":@"口腔科",@"describ":@"口干,口燥,神经性牙痛"},@{@"id":@"14",@"name":@"子宫类疾病",@"describ":@"子宫内膜炎,子宫癌"},@{@"id":@"15",@"name":@"儿童门诊",@"describ":@"儿童常见疾病"},@{@"id":@"16",@"name":@"儿童营养专科门诊",@"describ":@"儿童保健,营养不良,发育迟缓,小儿多动症等"},@{@"id":@"17",@"name":@"放射介入科",@"describ":@"放射性,电脑辐射检查科"},@{@"id":@"18",@"name":@"妇科",@"describ":@"月经不调,不孕不育,盆腔炎,子宫肌瘤"},@{@"id":@"19",@"name":@"风湿科",@"describ":@"风湿病,关节炎,痛风,强制性脊柱炎"},@{@"id":@"20",@"name":@"感染科",@"describ":@"放射科,电脑辐射检查科"},@{@"id":@"21",@"name":@"骨科",@"describ":@"骨质疏松,骨折,骨癌,遗传性骨病,骨股头坏死"}];
    [self handleData:array];
    [self _initTableView];
    [self _initIndexView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.sectionIndexView reloadItemViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#define kSectionIndexWidth 40.f
#define kSectionIndexHeight 360.f
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _sectionIndexView.frame = CGRectMake(CGRectGetWidth(self.tableview.frame) - kSectionIndexWidth, (CGRectGetHeight(self.tableview.frame) - kSectionIndexHeight)/2, kSectionIndexWidth, kSectionIndexHeight);
    [_sectionIndexView setBackgroundViewFrame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)_initIndexView
{
    _sectionIndexView = [[DSectionIndexView alloc] init];
    _sectionIndexView.backgroundColor = [UIColor clearColor];
    _sectionIndexView.dataSource = self;
    _sectionIndexView.delegate = self;
    _sectionIndexView.isShowCallout = YES;
    _sectionIndexView.calloutViewType = CalloutViewTypeForUserDefined;
    _sectionIndexView.calloutDirection = SectionIndexCalloutDirectionLeft;
    _sectionIndexView.calloutMargin = 100.f;
    [self.view addSubview:self.sectionIndexView];
}

- (void)_initTableView
{
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
}
- (void)handleData:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HMKindOffice *kindOffice = [HMKindOffice kindOfficeWithDictionary:obj];
        NSString *firstLetter = [self getFirstLetter:kindOffice];
        if (tempArray.count > 0) {
            __block NSInteger index = -1;
            [tempArray enumerateObjectsUsingBlock:^(HMOffice *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *letter = obj.letter;
                if ([firstLetter isEqualToString:letter]) {
                    [obj.kindArray addObject:kindOffice];
                    index = idx;
                }
            }];
            if (index == -1) {
                HMOffice *office = [[HMOffice alloc] init];
                office.letter = firstLetter;
                NSMutableArray *tempArr = [NSMutableArray array];
                [tempArr addObject:kindOffice];
                office.kindArray = tempArr;
                [tempArray addObject:office];
            }
        }else{
            HMOffice *office = [[HMOffice alloc] init];
            office.letter = firstLetter;
            NSMutableArray *tempArr = [NSMutableArray array];
            [tempArr addObject:kindOffice];
            office.kindArray = tempArr;
            [tempArray addObject:office];
        }
    }];
    //排序
    NSArray *iArr = [tempArray sortedArrayUsingComparator:^NSComparisonResult(HMOffice *obj1, HMOffice *obj2) {
        return [obj1.letter compare:obj2.letter];
    }];
    [self.dataArray addObjectsFromArray:iArr];
    
    [self.dataArray enumerateObjectsUsingBlock:^(HMOffice *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.indexTitleArray addObject:obj.letter];
    }];
    
    [self.tableview reloadData];
}
- (NSString *)getFirstLetter:(HMKindOffice *)kindOffice
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger index = [collation sectionForObject:kindOffice collationStringSelector:@selector(officename)];
    NSString *letter = self.letterArray[index];
    return letter;
}
#pragma mark UITableViewDataSource && delegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HMOffice *office = self.dataArray[section];
    return office.kindArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HMOffice *office = self.dataArray[section];
    return office.letter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"IdentifierCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    HMOffice *office = self.dataArray[indexPath.section];
    HMKindOffice *kindOffice = office.kindArray[indexPath.row];
    cell.textLabel.text = kindOffice.officename;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark DSectionIndexViewDataSource && delegate method
- (NSInteger)numberOfItemViewForSectionIndexView:(DSectionIndexView *)sectionIndexView
{
    return self.tableview.numberOfSections;
}

- (DSectionIndexItemView *)sectionIndexView:(DSectionIndexView *)sectionIndexView itemViewForSection:(NSInteger)section
{
    DSectionIndexItemView *itemView = [[DSectionIndexItemView alloc] init];
    
    HMOffice *office = self.dataArray[section];
    itemView.titleLabel.text = office.letter;
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor darkGrayColor];
    itemView.titleLabel.highlightedTextColor = [UIColor redColor];
    itemView.titleLabel.shadowColor = [UIColor whiteColor];
    itemView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    return itemView;
}

- (UIView *)sectionIndexView:(DSectionIndexView *)sectionIndexView calloutViewForSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, 80, 80);
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:36];
    HMOffice *office = self.dataArray[section];
    label.text = office.letter;
    label.textAlignment = NSTextAlignmentCenter;
    
    [label.layer setCornerRadius:label.frame.size.width/2];
    [label.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [label.layer setBorderWidth:3.0f];
    [label.layer setShadowColor:[UIColor blackColor].CGColor];
    [label.layer setShadowOpacity:0.8];
    [label.layer setShadowRadius:5.0];
    [label.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    return label;
}

- (NSString *)sectionIndexView:(DSectionIndexView *)sectionIndexView
               titleForSection:(NSInteger)section
{
    HMOffice *office = self.dataArray[section];
    return office.letter;
}

- (void)sectionIndexView:(DSectionIndexView *)sectionIndexView didSelectSection:(NSInteger)section
{
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}




@end


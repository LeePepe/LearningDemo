# Learning From Book

根据一本iOS开发教程书籍上的例子，加入部分变动，包含各种工具、Controller的使用等。

## Picker View

* plist文件中包含中国所有省份。「[下载地址](http://www.jianshu.com/p/6135aeb8b3ca)」
* 根据plist中的格式，定制了Province和City类型，并且在Province中根据plist结构提供初始化函数。
* Model为[Province]，Province中包含[City]。二者分别作为单独的Component，使delegate和datasource中的代码简洁化。

在PickerView的DataSource中，Component代表有多少个转轮，row表示每个转轮中的每一个选项。

* 在`pickerView(_ : UIPickerView, didSelectRow: Int, inComponent: Int)`中，当滚动Province列表时，更新City列表。

## CollectionView

* 通过datasource来设置每一个cell的内容。
* collection view根据cell大小自动分配Cell布局。

## Model Segue

LoginView可以进行登陆，或通过ModelSegue进入注册界面。在登陆一次后可不再登陆直接进入主界面。

* 通过Model和dismiss来实现Login和Register的界面切换。

    当前展示的ViewController是presentingViewController，所以调用dismiss时都是在presentingViewController。

* 两个ViewController分别调用Request中的`login(user: String, password: String)`和`register(user: String, password: String)`方法。在Request中实现的是简单的本地登陆逻辑。

* 在ViewController中进行简单的本地检查（是否有填写等），再交由Request检查。默认Request直接调用远程方法。
* 在PickerView中的DidLoad()打印当前登陆用户，并退出，以方便测试。

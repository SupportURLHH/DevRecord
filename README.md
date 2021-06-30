# DevRecord
开发记录：自定义NavigationBar、滑动返回页面控制（用于编辑发布页面防止直接退出）

## 自定义NavigationBar
#### 背景色
#### 下划线颜色
#### 是否需要下划线
#### 标题颜色
#### 自定义返回按钮图片
#### 右侧按钮图片

## 滑动返回页面控制
原理：hook UINavigationController的生命周期函数，更改它的interactivePopGestureRecognizer的 delegate=self，在UIGestureRecognizerDelegate的实现里，增加相关控制逻辑即可

![演示](https://github.com/SupportURLHH/DevRecord/blob/master/%E6%BC%94%E7%A4%BA.gif?raw=true)

# INOE
该项目为桂林电子科技大学2024年暑期进行的生存实习，鸿蒙北向的小组项目
## 环境说明
开发工具：DevEco Studio NEXT Developer Beta1
开发工具版本：5.0.3.403
SDK版本：API Version 11
## 项目说明
该项目主要使用ArkTS编写，使用HarmonyOS开发推荐使用的ArkUI框架进行界面开发
项目采用MVVM框架
数据持久层上，使用了推荐的两种本地持久化。用户首选项Preference 和 关系型数据库RelationStore，封装官方API实现了简单的Util类用于方法的特定环境调用
网络请求上，使用了鸿蒙库中的http请求API 以及 使用了 axios库提供的API
该项目中多处使用了异步方法，ArkTS语言中的异步方法使用async修饰词定义，同时主动封装为Promise。通过本项目，你可以体验到Promise用于解决异步方法回调问题的优越性

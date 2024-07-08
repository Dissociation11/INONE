import { CommonConstants as Common } from '../commons/constants/CommonConstants'
import { TabBarItem, TabBarMode } from '../model/TabContentModel'
import viewModel, { TabContentViewModel } from '../viewmodel/TabContentViewModel'
import { HomeView } from './HomeView'
import { MineView } from './MineView'
import { ShortFormView } from './ShortFormView'


//应用主界面
@Entry
@Component
export struct TabContentView{
  @State viewModel : TabContentViewModel = viewModel

  //底部导航栏内容框
  @Builder TabItemBuilder(item:TabBarItem , index : number){

    Column(){

      Image(this.viewModel.currentIndex === index ? item.selectedIcon : item.defaultIcon)
        .width($r("app.float.tabbar_icon_size"))
        .aspectRatio(1)
      Text(item.name)

    }.size({width : Common.FULL_PERCENT})
    .justifyContent(FlexAlign.Center)

  }

  build(){

    Column(){

      Tabs({barPosition : BarPosition.End , index : this.viewModel.currentIndex}){

        ForEach(viewModel.getTabInfo(),(item : TabBarItem ,index)=>{

          TabContent(){

            Column(){

              if(item.mode == TabBarMode.Home)
              {
                //主页
                HomeView()

              }else if(item.mode == TabBarMode.ShortForm){
                //短视频
                ShortFormView()

              }else if(item.mode == TabBarMode.Mine){
                //个人中心
                MineView()

              }

            }

          }.tabBar(this.TabItemBuilder(item , index))

        })

      }.barHeight("10%")
      .backgroundColor($r("app.color.tabbar_background_color"))
      .animationDuration(300)
      .onAnimationStart((index:number,targetIndex:number,event:TabsAnimationEvent)=>{
        this.viewModel.currentIndex = targetIndex
      })

    }.size({
      height : Common.FULL_PERCENT,
      width : Common.FULL_PERCENT })

  }
}
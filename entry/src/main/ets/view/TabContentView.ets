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

  @Builder TabItemBuilder(item:TabBarItem , index : number){

    Column(){

      Image(this.viewModel.currentIndex === index ? item.selectedIcon : item.defaultIcon)
        .width("24vp")
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

                HomeView()

              }else if(item.mode == TabBarMode.ShortForm){

                ShortFormView()

              }else if(item.mode == TabBarMode.Mine){

                MineView()

              }

            }

          }.tabBar(this.TabItemBuilder(item , index))

        })

      }.barHeight("10%")
      .backgroundColor(Color.White)
      .animationDuration(300)
      .onAnimationStart((index:number,targetIndex:number,event:TabsAnimationEvent)=>{
        this.viewModel.currentIndex = targetIndex
      })

    }.size({
      height : Common.FULL_PERCENT,
      width : Common.FULL_PERCENT })
    .backgroundColor($r("app.color.main_background_color"))

  }
}

@Preview
@Component
struct pre{
  build() {

  }
}
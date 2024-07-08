import { CommonConstants as Common } from '../commons/constants/CommonConstants'
import { TabBarItem } from '../model/TabContentModel'
import viewModel, { TabContentViewModel } from '../viewmodel/TabContentViewModel'


//应用主界面
@Entry
@Component
export struct TabContentView{
  @State viewModel : TabContentViewModel = viewModel


  @Builder TabItemBuilder(item : TabBarItem , selected : boolean){

    Column(){

      Image(selected ? item.selectedIcon : item.defaultIcon)
        .width("24vp")
        .aspectRatio(1)
      Text(item.name)

    }.size({width : Common.FULL_PERCENT})
    .justifyContent(FlexAlign.Center)

  }



  build(){

    Column(){

      Tabs({barPosition : BarPosition.End , index : viewModel.currentIndex}){

        ForEach(viewModel.getTabInfo(),(tabBarItem : TabBarItem , ind : number)=>{

          TabContent(){

            Column(){
              Text(tabBarItem.name)
              Text(ind.toString())
              Text(viewModel.currentIndex.toString())
            }

          }.tabBar(this.TabItemBuilder(tabBarItem,ind == viewModel.currentIndex))

        })

      }.barHeight("10%")
      .backgroundColor(Color.White)
      .onChange((index : number) => {
        viewModel.currentIndex = index
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
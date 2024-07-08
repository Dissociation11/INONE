import { CommonConstants as Common } from '../commons/constants/CommonConstants'
import { TabContentView } from '../view/TabContentView'

//程序主界面
@Entry
@Component
struct MainPage{

  build() {

    Column(){

      TabContentView()

    }.size({
      height : Common.FULL_PERCENT,
      width : Common.FULL_PERCENT
    })

  }
}
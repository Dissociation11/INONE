import { CommonConstants as Common } from '../commons/constants/CommonConstants'
import { TabContentView } from '../view/TabContentView'
import PreferenceUtil from '../commons/utils/preferenceUtil'
import { PreferenceConstant } from '../commons/constants/PreferenceConstant'

//程序主界面
@Entry
@Component
struct MainPage{

  @StorageLink("isDark") isDark: boolean = false

  aboutToAppear(): void {
    PreferenceUtil.hasKey(PreferenceConstant.IS_DARK).then((isExist) => {
      if (isExist) {
        PreferenceUtil.getPreferenceValue(PreferenceConstant.IS_DARK, false).then((value) => {
          this.isDark = value as boolean
          console.info(`info: isLogin is ${value.toString()}`)
        })
      } else {
        PreferenceUtil.putPreferenceValue(PreferenceConstant.IS_DARK, false)
        console.info('info: create isLogin preference')
      }
    })
  }

  build() {

    Column(){

      TabContentView()

    }.size({
      height : Common.FULL_PERCENT,
      width : Common.FULL_PERCENT
    })

  }
}
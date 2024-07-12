import userViewModel, { UserViewModel} from '../viewmodel/UserViewModel'
import { router } from '@kit.ArkUI'

@Component
export struct SettingView{
  @StorageLink("UserViewModel") userViewModel:UserViewModel  = userViewModel
  @StorageLink("isDark") isDark: boolean = false

  build() {
    Column(){
      Button('退出登录')
        .borderRadius(10)
        .width(300)
        .height(60)
        .onClick(() => {
          this.userViewModel.signOut()
          router.back()
        })
    }.margin({ top: 30 })
    .size({ height: "100%", width: "100%"})
    .backgroundColor(this.isDark ? $r('app.color.main_background_color_dark') : $r('app.color.main_background_color'))
  }
}
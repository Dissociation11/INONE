import Prompt from '@system.prompt';
import { LoginViewModel } from '../viewmodel/LoginViewModel'
import userViewModel, { UserViewModel} from '../viewmodel/UserViewModel'
import { router } from '@kit.ArkUI';

@Component
export struct LoginView{
  @State viewModel: LoginViewModel = new LoginViewModel()
  @StorageLink("UserViewModel") userViewModel:UserViewModel  = userViewModel

  build(){
    Column(){

      Row(){
        Image($r('app.media.Login_top'))
          .width(200)
          .height(100)
          .objectFit(ImageFit.Auto)
      }.margin({ top: 30 })

      Row(){
        Image($r('app.media.login_user'))
          .width(30)
          .height(30)
        TextInput({placeholder: $r('app.string.UserName')})
          .margin(({top: 20 }))
          .width(300)
          .height(60)
          .backgroundColor('#395e5d64')
          .onChange((value: string) => {
            this.viewModel.username = value
          })
      }.margin({ top: 70 })

      Row(){
        Image($r('app.media.login_password'))
          .width(30)
          .height(30)
        TextInput({placeholder: $r('app.string.Password')}).type((InputType.Password))
          .margin({top : 20})
          .width(300)
          .height(60)
          .backgroundColor("#395e5d64")
          .onChange((value: string) => {
            this.viewModel.password = value
          })
      }

      Row(){
        Checkbox()
          .selectedColor($r("app.color.LOGIN_COLOR"))
          .onChange((isSelected: boolean) => {
            this.viewModel.isSelected = isSelected
          })
        Text($r('app.string.PleaseTick'))
          .margin({ left: 5 })
        Text($r('app.string.UserAgreement'))
          .fontColor($r('app.color.LOGIN_COLOR'))
        Text($r('app.string.And'))
        Text($r('app.string.PrivacyPolicy'))
          .fontColor($r("app.color.LOGIN_COLOR"))
      }.width("100%")
      .justifyContent(FlexAlign.Center)
      .margin({ top: 20 })

      Button($r('app.string.Login'))
        .width(300)
        .height(50)
        .margin({ top : 30})
        .backgroundColor($r('app.color.LOGIN_COLOR'))
        .onClick(() => {
          this.viewModel.clickLogin().then((loginFlag)=>{
            if(loginFlag) {
              this.userViewModel.login(this.viewModel.username, this.viewModel.password).then((isOk) => {
                if (isOk) {
                  router.replaceUrl({
                    url: 'pages/Transition'
                  })
                }
              })
            }
          })
        })

      Row(){

        Text($r('app.string.Register'))
          .margin({ top: 10, right: 80 })
          .fontSize(20)
          .fontColor($r('app.color.LOGIN_COLOR'))
          .onClick(() => {
            this.viewModel.clickRegister()
          })

        Text($r('app.string.ForgotPassword'))
          .fontSize(20)
          .margin({ left: 10, top: 10})
          .fontColor($r('app.color.LOGIN_COLOR'))
          .onClick(() => {
            this.viewModel.forgetPassword()
          })
      }
      Image($r('app.media.Login_di'))
        .width(200)
        .height(180)
        .objectFit(ImageFit.Cover)
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundImageSize(ImageSize.Cover)
  }
}
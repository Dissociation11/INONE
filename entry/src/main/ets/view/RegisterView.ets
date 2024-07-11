import { RegisterViewModel } from '../viewmodel/RegisterViewModel'


@CustomDialog
export struct CustomDialogExample {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({}),
  })

  build() {
    Column() {
      Text('验证码: 123456')
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })

    }.width('100%')
    .height(100)
    .margin({ top: 50})
  }
}

@Component
export struct RegisterView{

  @State viewModel: RegisterViewModel = new RegisterViewModel()

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample(),
  })


  build(){
    Column(){
      Row(){
        Image($r('app.media.res1'))
          .width(300)
          .height(100)
          .objectFit(ImageFit.Auto)
      }.margin({ top: 80 })

      Row(){
        TextInput({placeholder: $r('app.string.UserName')})
          .margin({ top: 20})
          .width(300)
          .height(60)
          .backgroundColor('#395e5d64')
          .onChange((value: string) => {
            this.viewModel.phone = value
          })
      }

      Row(){
        TextInput({placeholder: $r('app.string.phone')})
          .margin({ top: 20})
          .width(300)
          .height(60)
          .backgroundColor('#395e5d64')
          .onChange((value: string) => {
            this.viewModel.phone = value
          })
      }

      Row(){
        TextInput({placeholder: $r('app.string.Captcha')})
          .margin({ top: 20, right:30})
          .width(180)
          .height(60)
          .backgroundColor('#395e5d64')
          .onChange((value: string) => {
            this.viewModel.captcha = value
          })
        Button($r('app.string.GetCaptcha'))
          .borderRadius(8)
          .backgroundColor($r('app.color.LOGIN_COLOR'))
          .width(100)
          .height(40)
          .onClick(() => {
            this.dialogController.open()
          })
      }

      Row(){
        TextInput({ placeholder: $r('app.string.Password') })
          .type(InputType.Password)
          .margin({ top: 20 })
          .width(300)
          .height(60)
          .backgroundColor('#395e5d64')
          .onChange((value: string) => {
            this.viewModel.password = value
          })
      }

      Row(){
        Checkbox()
          .selectedColor($r('app.color.LOGIN_COLOR'))
          .onChange((isSelected: boolean) => {
            this.viewModel.isSelected = isSelected
          })
        Text($r('app.string.ReadAndAgreen'))
          .margin({ left: 5 })
        Text($r('app.string.UserAgreement'))
          .fontColor($r('app.color.LOGIN_COLOR'))
        Text($r('app.string.PrivacyPolicy'))
          .fontColor($r('app.color.LOGIN_COLOR'))
      }.width("100%")
      .justifyContent(FlexAlign.Center)
      .margin({ top: 20 })

      Button($r('app.string.Register'))
        .width(330)
        .height(50)
        .margin({ top: 30 })
        .backgroundColor($r('app.color.LOGIN_COLOR'))
        .onClick(() => {

        })
    }
    .width('100%')
    .height('100%')
    .backgroundImageSize(ImageSize.Cover)
  }

}
import router from '@ohos.router'
import Prompt from '@system.prompt';


@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({}),
  })

  build() {
    Column() {
      Text('我是内容')
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })

    }.width('100%')
    .height(100)
    .margin({ top: 50})
  }
}

@Entry
@Component
struct Register{
  @State username: string = ''
  @State password: string = ''
  @State captcha: string = ''
  @State isSelected: boolean = false

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
          TextInput({placeholder: '手机号/邮箱'})
            .margin({ top: 20})
            .width(300)
            .height(60)
            .backgroundColor('#395e5d64')
            .onChange((value: string) => {
              this.username = value
            })
        }

        Row(){
          TextInput({placeholder: '验证码'})
            .margin({ top: 20, right:30})
            .width(180)
            .height(60)
            .backgroundColor('#395e5d64')
            .onChange((value: string) => {
              this.captcha = value
            })
          Button('获取验证码')
            .borderRadius(8)
            .backgroundColor($r('app.color.LOGIN_COLOR'))
            .width(100)
            .height(40)
            .onClick(() => {
              this.dialogController.open()
            })
        }

        Row(){
          TextInput({ placeholder: '设置密码' })
            .type(InputType.Password)
            .margin({ top: 20 })
            .width(300)
            .height(60)
            .backgroundColor('#395e5d64')
            .onChange((value: string) => {
              this.password = value
            })
        }

        Row(){
          Checkbox()
            .selectedColor($r('app.color.LOGIN_COLOR'))
            .onChange((isSelected: boolean) => {
              this.isSelected = isSelected
            })

          Text("我已阅读并同意")
            .margin({ left: 5 })
          Text("《xxx用户协议》")
            .fontColor($r('app.color.LOGIN_COLOR'))
          Text("《隐私政策》")
            .fontColor($r('app.color.LOGIN_COLOR'))
        }.width("100%")
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        Button('注册')
          .width(330)
          .height(50)
          .margin({ top: 30 })
          .backgroundColor($r('app.color.LOGIN_COLOR'))
          .onClick(() => {
            if(!this.isSelected){
              Prompt.showToast({message:"请勾选《xxx用户协议》和《隐私政策》"})
              return
            }if(this.username !== ''){
              if(this.password !== ''){
                if( this.captcha !== ''){
                  Prompt.showToast({message:"注册成功！"})
                  router.pushUrl({
                    url: 'pages/Login',
                    params: {
                      username: this.username,
                      password: this.password,
                      captcha: this.captcha
                    }
                  })
                }else{
                  Prompt.showToast({message:"请输入验证码！"})
                }
              }else{
                Prompt.showToast({message:"请输入验证码和密码！"})
              }
            }
            else{
              Prompt.showToast({message:"请输入手机号,验证码和密码！"})
            }
          })
      }
    .width('100%')
    .height('100%')
    .backgroundImageSize(ImageSize.Cover)
  }
}



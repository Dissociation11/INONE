import  router  from '@ohos.router';
import Prompt from '@system.prompt';

@Entry
@Component
struct Login {
  @State username: string = ''
  @State password: string = ''
  @State isSelected: boolean = false

  build() {
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
          TextInput({placeholder: '用户名'})
            .margin(({top: 20 }))
            .width(300)
            .height(60)
            .backgroundColor('#395e5d64')
            .onChange((value: string) => {
              this.username = value
            })
        }.margin({ top: 70 })

        Row(){
          Image($r('app.media.login_password'))
            .width(30)
            .height(30)
          TextInput({placeholder: '密码'}).type((InputType.Password))
            .margin({top : 20})
            .width(300)
            .height(60)
            .backgroundColor("#395e5d64")
            .onChange((value: string) => {
              this.password = value
            })
        }

        Row(){
          Checkbox()
            .selectedColor($r("app.color.LOGIN_COLOR"))
            .onChange((isSelected: boolean) => {
              this.isSelected = isSelected
            })

          Text("请勾选")
            .margin({ left: 5 })
          Text("《用户协议》")
            .fontColor($r('app.color.LOGIN_COLOR'))
          Text("和")
          Text("《隐私政策》")
            .fontColor($r("app.color.LOGIN_COLOR"))
        }.width("100%")
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        Button('登录')
          .width(300)
          .height(50)
          .margin({ top : 30})
          .backgroundColor($r('app.color.LOGIN_COLOR'))
          .onClick(() => {
            if(!this.isSelected){
              Prompt.showToast({message:"请勾选用户协议和隐私政策"})
              return
            }
            if(this.username === "" && this.password === "") {
              router.pushUrl({
                url: 'pages/Transition',
                params: {
                  username: this.username,
                  password: this.password
                }
              })
            } else {
              Prompt.showToast({message:"账号或密码错误！"})
            }
          })
        Row(){
          Text('注册')
            .margin({ top: 10, right: 80 })
            .fontSize(20)
            .fontColor($r('app.color.LOGIN_COLOR'))
            .onClick(() => {
              router.pushUrl({
                url:'pages/Register'
              })
            })
          Text('忘记密码')
            .fontSize(20)
            .margin({ left: 10, top: 10})
            .fontColor($r('app.color.LOGIN_COLOR'))
            .onClick(() => {
              Prompt.showToast({message:"我也不知道！"})
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
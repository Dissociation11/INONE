import router from '@ohos.router'
import Prompt from '@system.prompt';

export class RegisterViewModel{

  username: string = ''
  password: string = ''
  phone: string = ''
  captcha: string = ''
  isSelected: boolean = false

  register(){
    if(!this.isSelected){
      Prompt.showToast({message:"请勾选《xxx用户协议》和《隐私政策》"})
      return
    }if(this.username !== ''){
      if(this.password !== ''){
        if( this.captcha !== ''){
          Prompt.showToast({message:"注册成功！"})
          router.back()
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
  }

}
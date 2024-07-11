import router from '@ohos.router'
import Prompt from '@system.prompt';

export class RegisterViewModel{

  username: string = ''
  password: string = ''
  phone: string = ''
  captcha: string = ''
  isSelected: boolean = false

  async register(){
    if(!this.isSelected){
      Prompt.showToast({message:"请勾选《xxx用户协议》和《隐私政策》"})
      return false
    }
    if(this.phone.length != 11){
      Prompt.showToast({message: '请输入正确得手机号'})
      return false
    }
    if(this.username == ''){
      Prompt.showToast({message:"请输入用户名"})
      return false
    }else if(this.password == ''){
      Prompt.showToast({message:"请输入密码"})
      return false
    }else if(this.captcha == ''){
      Prompt.showToast({message:"请输入验证码"})
      return false
    }
    if(this.captcha != '123456'){
      Prompt.showToast({message:"验证码错误"})
      return false
    }
    return true
  }

}
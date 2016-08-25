<?php
session_start();
$num=4;//验证码个数
$width=50;//验证码宽度
$height=30;//验证码高度
$code=' ';
for($i=0;$i<$num;$i++)//生成验证码
{
//  switch(rand(0,2))
//  {
//      case 0:$code[$i]=chr(rand(48,57));break;//数字
//      case 1:$code[$i]=chr(rand(65,90));break;//大写字母
//      case 2:$code[$i]=chr(rand(97,122));break;//小写字母
//  }
    $code[$i]=chr(rand(48,57));
}
$_SESSION["LoginVerifyCode"] = $code;
$image=imagecreate($width,$height);
imagecolorallocate($image,255,255,255);
for($i=0;$i<$num;$i++)//打印字符到图像
{
    $char_color=imagecolorallocate($image,rand(0,2555),rand(0,255),rand(0,255));
    imagechar($image,60,($width/$num)*$i,rand(0,5),$code[$i],$char_color);
}
header("Content-type:image/jpeg");
imagejpeg($image,null,100);//输出图像到浏览器
imagedestroy($image);//释放资源
?>
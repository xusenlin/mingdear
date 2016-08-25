<?php
namespace app\api\controller;
use think\db;

class User  //这个控制器类名字要和文件名一样
{
    public function index()
    {
        return '用户数据调用！';
    }

    public function all()
    {
        $data = db('users')->select();
        return json_encode($data);
    }
}

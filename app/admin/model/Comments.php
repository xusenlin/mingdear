<?php

namespace app\admin\model;
use think\Model;

class Comments extends Model
{

    /*
     * 获取评论总数
     */
    public function get_comments_total(){
        return $this->count();
    }

    /*
     * 获取评论列表
     */
    public  function get_comments_list($limit){
        return $this->paginate($limit);
    }

}
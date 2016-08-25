<?php

namespace app\admin\model;

use think\Model;

class Users extends Model
    {
        
        /*
         * 获取用户总数
         */
        public function get_user_total(){

            return $this->where('type','<>', 'admin')->count();
        }
        /*
         * 获取管理员总数
         */
        public function get_admin_total(){
    
            return $this->where('type', 'admin')->count();
        }
        /*
         * 获取用户列表
         */
        public  function get_user_list($limit){
            return $this->where('type','<>', 'admin')->paginate($limit);
        }



    }
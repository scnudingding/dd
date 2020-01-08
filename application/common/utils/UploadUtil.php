<?php
/**
 * Created by PhpStorm.
 * User: kwd
 * Date: 2018/2/7 0007
 * Time: 13:34
 */

namespace app\common\utils;


use think\File;
use think\Image;

class UploadUtil {

    /***************************所有图片均以相对地址操作***************************************/


    /**
     * 上传单张图片不含host
     * @param File $img
     * @param $savePath
     * @param $is_md5   文件名是否md5加密，true-MD5加密
     * @return bool|string
     */
    public static function uploadImg(File $img, $savePath, $is_md5){
        $savePath = '/public/uploads/'.$savePath.'/';
        //设置文件上传限制，允许上传的最大文件大小：10M，类型为jpg或png
        $img->validate(['size' => 10485760, 'ext' => 'jpg,png']);
        $imgComp = Image::open($img);
        $fileName =time().'.png';
        if ($is_md5==true){
            $fileName = md5($fileName).'.png';
        }
        $imgUploadResult = $imgComp->thumb(360, 360)
            ->save(ROOT_PATH.$savePath.DS.$fileName,'png');
        if ($imgUploadResult) {
            return $savePath . $fileName;
        }else{
            return false;
        }
    }

    /**
     * 上传多张图片
     * @param $imgs
     * @param $savePath
     * @return array
     */
    public static function uploadImgs($imgs,$savePath,$is_md5){
        $i = 1;
        $savePath = '/public/uploads/'.$savePath.'/';
        $imgSet = array();
        foreach ($imgs as $img) {
            //设置文件上传限制，允许上传的最大文件大小：10M，类型为jpg或png
            $img->validate(['size' => 10485760, 'ext' => 'jpg,png']);
            $imgComp = Image::open($img);
            $fileName = time().'_'.$i .'.png';
            if ($is_md5==true){
                $fileName = md5($fileName).'.png';
            }
            $imgUploadResult = $imgComp->thumb(360, 360)
                ->save(ROOT_PATH.$savePath.DS.$fileName,'png');
            if ($imgUploadResult) {
                $imgSet[] =  $savePath . $fileName;
            }
            $i++;
        }
        return $imgSet;
    }

    /**
     * 删除单张图片
     * @param $img
     */
    public static function deleteImg($img) {
        unlink(ROOT_PATH . DS . $img);
    }


    /**
     * 删除图片
     * @param array $imgs
     * @return bool
     */
    public static function deleteImgs(array $imgs){
        for ($i = 0; $i <= count($imgs); $i++) {
            unlink(ROOT_PATH . DS . $imgs[$i]);
        }
        return true;
    }

}
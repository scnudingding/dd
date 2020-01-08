<?php

/**
 * Created by PhpStorm.
 * User: wuzhenpeng
 * Date: 2020/01/05
 * Time: 14:06
 * 常用工具类
 */
class PubMyUtil
{
	/**
	 * curl请求
	 * GET请求时，可直接可直接在url后面带参数，也可传递params参数数组，会自动组装
	 * @param string $url 请求地址
	 * @param array $params 请求参数(已做urlencode处理)
	 * @param number $expire 延迟
	 * @param string $method 请求方式(POST/GET)
	 * @param string $hostIp 请求的具体IP(用于一个域名多台服务器的情况)
	 * @param array $extend curl扩展设置
	 * @return array    数组格式返回array('result'=>'', 'code'=>'')
     * @usage TP5用法（\PubMyUtil::makeRequest('www.baidu.com')）
	 */
	public static  function makeRequest($url, $params = array(), $method = 'GET', $expire = 5, $hostIp = '', $extend = array())
	{
		$_curl = curl_init();
		$_header = array(
			'Accept-Language: zh-cn',
			'Connection: Keep-Alive',
			'Cache-Control: no-cache',
			'CLIENT-IP:118.126.92.254',
			'X-FORWARDED-FOR:118.126.92.254',
		);
		// 方便直接访问要设置host的地址
		if (!empty($hostIp)) {
			$urlInfo = parse_url($url);
			$url = str_replace($urlInfo['host'], $hostIp, $url);
			$_header[] = "Host: {$urlInfo['host']}";
		}

		//POST请求
		if ($method == 'POST') {
			curl_setopt($_curl, CURLOPT_POST, true);
			curl_setopt($_curl, CURLOPT_POSTFIELDS, urldecode(http_build_query($params)));
		} //GET请求
		else {
			//不带'?'时，拼接参数
			if ((strpos($url, '?') === false) && !empty($params)) {
				$url = $url . '?' . http_build_query($params);
			}
		}

		curl_setopt($_curl, CURLOPT_URL, $url);
		curl_setopt($_curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($_curl, CURLOPT_USERAGENT, 'ZOUZOU.WORK API PHP Servert 0.5 (curl) ');
		curl_setopt($_curl, CURLOPT_HTTPHEADER, $_header);
		curl_setopt($_curl, CURLOPT_TIMEOUT, $expire); // 处理超时时间
		curl_setopt($_curl, CURLOPT_CONNECTTIMEOUT, $expire); // 建立连接超时时间
        curl_setopt($_curl, CURLOPT_SSL_VERIFYPEER, FALSE); // https请求 不验证证书和hosts
        curl_setopt($_curl, CURLOPT_SSL_VERIFYHOST, FALSE);

		// 额外的配置
		if (!empty($extend)) {
			curl_setopt_array($_curl, $extend);
		}

		$result['result'] = curl_exec($_curl);
		$result['code'] = curl_getinfo($_curl, CURLINFO_HTTP_CODE);
		if ($result['result'] === false) {
			$result['result'] = curl_error($_curl);
			$result['code'] = -curl_errno($_curl);
		}
		curl_close($_curl);
		unset($_curl);
		return $result;
	}

	/**
	 * 记录日志方法
	 * @param $array
	 * @param string $path
	 * @param string $fileName
	 * @param bool $export
     * @usage
     * TP5用法（\PubMyUtil::log('www.baidu.com','wuzhenpeng','log')
     * 调试最好把结果打印在服务器日志上，别直接echo到页面上
	 */
	public static function log($array , $path = '',$fileName = 'defalut',$export = true){
		if(is_array($array)){
			if(!$export)
				$array = json_encode($array);
			else
				$array = var_export($array,true);
		}
		$path = empty($path)?'test':$path;
		$path = PATH_LOG.'/'.$path.'/';
		$log = $path . $fileName ."_". date("Ymd") . '.log';
		//保证admin和www用户都有写权限，否则会导致某些日志写不进去
		if (!is_file($log)) {
			$dir = dirname($log);
			if (!is_dir($dir)) {
				mkdir($dir, 0777, true);   //创建目录
				chmod($dir, 0777);
			}
			touch($log);    //创建文件
			chmod($log, 0666);  //改变文件权限
		}
		file_put_contents($log, $array."\r\n", FILE_APPEND);
	}

}
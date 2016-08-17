<?php

class DDApi{

	protected $API_KEY;
	protected $USER_AGENT;

	protected $base = Array(
		'User' => 'http://api.discorddungeons.me/user',
	);

	public function __construct($API_KEY, $USER_AGENT){
		$this->API_KEY = $API_KEY;
		$this->USER_AGENT = $USER_AGENT;
	}

	private function getRequest($url){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_USERAGENT, $this->USER_AGENT);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

		curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-Api-Key: '.$this->API_KEY));

		$output = curl_exec($ch);
		curl_close($ch);
		return $output;
	}

	private function exceptionHandler($exception){
		echo $exception->getMessage()."\n";
	}

	public function getUserById($id){
		$data = json_decode($this->getRequest($this->base["User"]."/".$id));
		if($data->status == 401){
			//set_exception_handler($this->exceptionHandler);
			error("[DDAPI] Error! Unautorized.");
		}
	}
}
<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST") {

	$response = array();
	$nama = $_POST['nama'];
	$no_bp = $_POST['no_bp'];
	$no_hp = $_POST['no_hp'];
	$email = $_POST['email'];

	$cek = "SELECT * FROM pegawai WHERE nama = '$nama' || email = '$email'";
	$result = mysqli_fetch_array(mysqli_query($koneksi, $cek));

	if(isset($result)){
		$response['value'] = 2;
		$response['message'] = "nama atau email telah digunakan";
		echo json_encode($response);
	} else {
		$insert = "INSERT INTO pegawai VALUE(NULL, '$nama', '$no_bp', '$no_hp', '$email', NOW())";
		if(mysqli_query($koneksi, $insert)){
			$response['value'] = 1;
			$response['message'] = "Berhasil didaftarkan";
			echo json_encode($response);
		} else {
			$response['value'] = 0;
			$response['message'] = "Gagal didaftarkan";
			echo json_encode($response);
		}
	}
}

?>
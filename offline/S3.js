var Minio = require('minio');

try{
	var minioClient = new Minio.Client({
     	endPoint: "192.168.1.7",
     	port:9000,
	 	useSSL:false,
	 	// accessKey: 'CZ5MTXJLFK9WPWVZXRI1',
     	// secretKey: 'splHypa18nqtr9yjYoZaP2/dSjgHv+kB1kkzz8HF'
     accessKey: '6ZSSSAB4Z61CYOMSMB8L',
	 secretKey: 'Hfkb3lDklFEH74c5Ymhuim8IqhAez70MLapbCpjC'
	
	});
	// minioClient.listBuckets(function(err, buckets) {
	//   if (err) return console.log(err)
	//   console.log('buckets :', buckets)
	// });

}catch (e){
	console.log(e);
}

// var S3 = new Minio.Client({
//      endPoint: "http://127.0.0.1",
//      port:9000,
//      accessKey: 'V5ZGL06ITLYXVFCBB4VS',
//      secretKey: 'NBHRoCLFVGk3AczTf6bPGzHlPqh4y80WhcfxnbAZ'
// });

// console.log(S3);

module.exports = minioClient;


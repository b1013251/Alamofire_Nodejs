var express = require('express');
var multer = require('multer');
var fs = require('fs');
var crypto = require('crypto');
var mime = require('mime');

var app = express();

var storage = multer.diskStorage({
	destination: function(req, file, cb) {
		cb(null, './public/images/');
	},
	filename: function(req, file, cb) {
		crypto.pseudoRandomBytes(16, function(err, raw) {
			cb(null, raw.toString('hex') + Date.now() + '.' + mime.extension(file.mimetype));
		});
	}
});
var upload = multer({
	storage: storage
}).single('images');

app.use(express.static('./public'));

app.post('/upload', function(req, res) {
    upload(req, res, function(err) {
        if(err || undefined == req.file) {
            res.send("failed to upload");
        } else {
            console.log(req.file)
            res.send("uploaded " + req.file.originalname + " as " + req.file.filename);
        }
    });
});

app.get('/images', function(req,res) {
    fs.readdir('./public/images', function(err, files) {
        if(err) throw err;
        var fileList = [];
        files.forEach(function(file) {
            fileList.push({"name":file});
        })
        res.send(JSON.stringify(fileList));
    })
});

app.listen(8000, function() { console.log("listening"); });

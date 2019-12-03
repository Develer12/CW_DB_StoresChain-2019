const sql = require('mssql');
const express = require('express');
const fs = require('fs');
var bodyParser = require('body-parser');
//DB handler
const Db = require('./queries');
const DB = new Db();



const PORT = 3000;
const HOST = 'localhost';

const app = express();
app.use(bodyParser.json())
const server = app.listen(PORT, HOST, () =>
{
    const URL = `http://${HOST}:${PORT}`;
    console.log('Listening on ' + URL);
})
.on('error', (e) => {console.log(`${URL} | error: ${e.code}`)});



//-----GET------
app.get('/', (req, res) =>
{
    res.sendFile(__dirname + '/index.html');
});

//-----Image Handler------
app.get('/ResHandler/:name/:ext', (req, res) =>
{
    let Name = req.params.name;
    let Ext = req.params.ext;
    switch (Ext)
    {
      case 'png':
        res.writeHead(200, {'Content-Type' : `image/${Ext}`});
        res.end(fs.readFileSync(`${__dirname}/resourse/img/${Name}.${Ext}`));
        break;
      case 'js':
        res.writeHead(200, {'Content-Type' : 'text/javascript; charset=utf-8'});
        res.end(fs.readFileSync(`${__dirname}/resourse/js/${Name}.${Ext}`));
        break;
      case 'css':
        res.writeHead(200, {'Content-Type' : 'text/css; charset=utf-8'});
        res.end(fs.readFileSync(`${__dirname}/resourse/css/${Name}.${Ext}`));
        break;
      default:
        res.write("File not found");
        res.end();
    }
});

app.get('/api/:tab/:end/:st/:order', (req, res) =>
{
    console.log('Get Tab');
    getHand(req, res);
});


function getHand(req, res)
{
    let o = req.params.order;
    if(o == 'no') o = ' ';
    else o = "'"+o+"',";
    DB.Get(req.params.tab, req.params.end, req.params.st, o).then(records =>
    {res.json(records.recordset);}).catch(error =>
        {
            res.statusCode = 400;
            res.json({error: String(error)});
        });
}

//-----EXPORT------
app.get('/export/:type', (req, res) =>
{
    console.log('Export');
    var filePath = '../backups/STORES_CHAIN.bak';
    if (fs.existsSync(filePath) && req.params.type =='ExDB')
      fs.unlinkSync(filePath);
    DB.Export(req.params.type).catch(error =>
    {
        res.statusCode = 400;
        res.json({error: String(error)});
    });
});

//-----IMPORT------
app.get('/import/:type', (req, res) =>
{
    console.log('Import');
    var filePathDB = '../backups/STORES_CHAIN.bak';
    var filePathXML = '../backups/Import.xml';
    if ((fs.existsSync(filePathDB) && req.params.type =='ImDB') || (req.params.type =='ImProdfromXml' && fs.existsSync(filePathXML)))
      DB.Export(req.params.type).catch(error =>
      {
          res.statusCode = 400;
          res.json({error: String(error)});
      });
    else if(!fs.existsSync(filePathDB)) console.log('BAK file to restore DB not exists');
    else if(!fs.existsSync(filePathXML)) console.log('XML file to import products not exists');
});

//-----POST------
app.post('/api/faculties', (req, res) =>
{
    console.log('Get faculties');
    postHand('FACULTY', req, res);
});

app.post('/api/pulpits', (req, res) =>
{
    console.log('Get pulpits');
    postHand('PULPIT', req, res);
});

app.post('/api/subjects', (req, res) =>
{
    console.log('Get subjects');
    postHand('SUBJECT', req, res);
});

app.post('/api/auditortype', (req, res) =>
{
    console.log('Get Auditorium Type');
    postHand('AUDITORIUM_TYPE', req, res);
});

app.post('/api/auditor', (req, res) =>
{
    console.log('Get Auditorium');
    postHand('AUDITORIUM', req, res);
});

function postHand()
{
    DB.Insert(object, req.body).then(record =>
    {res.json(record.recordset[0]);}).catch(error =>
    {
        res.statusCode = 400;
        res.json({error: String(error)});
    });
}

//-----PUT------
app.put('/api/faculties', (req, res) =>
{
    console.log('Get faculties');
    putHand('FACULTY', req, res);
});

app.put('/api/pulpits', (req, res) =>
{
    console.log('Get pulpits');
    putHand('PULPIT', req, res);
});

app.put('/api/subjects', (req, res) =>
{
    console.log('Get subjects');
    putHand('SUBJECT', req, res);
});

app.put('/api/auditortype', (req, res) =>
{
    console.log('Get Auditorium Type');
    putHand('AUDITORIUM_TYPE', req, res);
});

app.put('/api/auditor', (req, res) =>
{
    console.log('Get Auditorium');
    putHand('AUDITORIUM', req, res);
});

function putHand()
{
    DB.Update(object, req.body).then(record =>
    {res.json(record.recordset[0]);}).catch(error =>
    {
        res.statusCode = 400;
        res.json({error: String(error)});
    });
}

//-----DELETE------
app.delete('/api/faculties/:xy', (req, res) =>
{
    let xy = req.params.xy;
});

app.delete('/api/pulpits/:xy', (req, res) =>
{
    let xy = req.params.xy;
});

app.delete('/api/subjects/:xy', (req, res) =>
{
    let xy = req.params.xy;
});

app.delete('/api/auditortype/:xy', (req, res) =>
{
    let xy = req.params.xy;
});

app.delete('/api/auditor/:xy', (req, res) =>
{
    let xy = req.params.xy;
});

app.get('/drop', (req, res) =>
{

});

app.get('/create', (req, res) =>
{

});

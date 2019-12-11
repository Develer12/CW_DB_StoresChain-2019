const sql = require('mssql');
const express = require('express');
const fs = require('fs');
var bodyParser = require('body-parser');
//DB handler
const Db = require('./queries');
const DB = new Db();
const urlencodedParser = bodyParser.urlencoded({extended: false});



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
    res.sendFile(__dirname + '/login.html');
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

//-----Login------
app.post('/api/login', urlencodedParser, (req, res) =>
{
    let au;
    console.log('Log function');

    if(req.body.login && req.body.password)
      DB.Login(req.body.login, req.body.password)
      .then(records =>
          { au = ((records.recordset));})
      .then(()=>
          {
              au = au.find(x => x.login).login;
              console.log(au);

              if(au == 1)
                res.sendFile(__dirname + '/index.html');
              else
                res.sendFile(__dirname + '/login.html');
          })
      .catch(error =>
          {
              res.statusCode = 400;
              res.json({error: String(error)});
          });
    else res.sendFile(__dirname + '/login.html');

});

//-----LogOut------
app.get('/LogOut', (req, res) =>
{
    console.log('User LogOut');
    res.sendFile(__dirname + '/login.html');
});

//-----------------------------------------------------------
//-----------------------------------------------------------
//------------------Get Table------------------------------
app.get('/api/:tab/:end/:st/:order', (req, res) =>
{
    console.log(`Get Tab: /api/${req.params.tab}/${req.params.end}/${req.params.st}/${req.params.order}`);
    let o = req.params.order;
    if(o == 'no') o = ' ';
    else o = "'"+o+"',";
    DB.Get(req.params.tab, req.params.end, req.params.st, o).then(records =>
    {res.json(records.recordset);}).catch(error =>
        {
            res.statusCode = 400;
            res.json({error: String(error)});
        });
});


//------------------Get Def value for option------------------------------
app.get('/api/opt/:tab/:sh', (req, res) =>
{
    console.log(`Get Tab: /api/opt/${req.params.tab}/${req.params.sh}`);
    let o = req.params.sh;
    if(o == 'no') o = ' ';
    else o = "'"+o+"'";
    DB.GetOpt(req.params.tab, o).then(records =>
    {
      let resopt = records.recordset;
      let opts = '';
      resopt.forEach(row =>
      {
        let rowN;
        for (key in row)
            rowN=(row[key]);
        opts+= `<option value="${rowN}">${rowN}</option>`;
      });
      res.json(opts);
    }).catch(error =>
        {
            res.statusCode = 400;
            res.json({error: String(error)});
        });
});


//-----------------------------------------------------------
//-----------------------------------------------------------

//-----EXPORT------
app.get('/export/:type', (req, res) =>
{
    console.log('Export' + req.params.type);
    var filePath = '../backups/STORES_CHAIN.bak';
    if (fs.existsSync(filePath) && req.params.type =='ExDB')
      fs.unlinkSync(filePath);
    DB.Exp_Imp(req.params.type).catch(error =>
    {
        res.statusCode = 400;
        res.json({error: String(error)});
    });
});

//-----IMPORT------
app.get('/import/:type', (req, res) =>
{
    console.log('Import' + req.params.type);
    var filePathDB = '../backups/STORES_CHAIN.bak';
    var filePathXML = '../backups/Import.xml';
    if ((fs.existsSync(filePathDB) && req.params.type =='ImDB') || (req.params.type =='ImProdfromXml' && fs.existsSync(filePathXML)))
      DB.Exp_Imp(req.params.type).catch(error =>
      {
          res.statusCode = 400;
          res.json({error: String(error)});
      });
    else if(!fs.existsSync(filePathDB)) console.log('BAK file to restore DB not exists');
    else if(!fs.existsSync(filePathXML)) console.log('XML file to import products not exists');
});

//-----Control_DB (Add, Delete, Update)------
app.post('/control/:fun/:exec', urlencodedParser, (req, res) =>
{
    let param = '';
    let json = req.body;
    let Exec = req.params.exec+req.params.fun;
    console.log(`${Exec} in DB`);
    console.log(json);
    for (key in json)
    {
      if(key == 'BarCode' || key == 'Depart' || key == 'Type')
        param+=("'"+json[key]+"',");
      else
        param+=(json[key]+',');
    }
    param = param.slice(0, param.length-1);
    console.log(param);
    DB.Control_DB(Exec, param).catch(error =>
    {
        res.statusCode = 400;
        res.json({error: String(error)});
    });
});

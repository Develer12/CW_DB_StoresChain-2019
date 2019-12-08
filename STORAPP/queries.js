const sql = require('mssql/msnodesqlv8');

let connectionPool;
const config =
{
    "driver": "msnodesqlv8",
    "connectionString": "Driver={SQL Server Native Client 11.0};Server={DESKTOP-U4BLHC6};Database={STORES_CHAIN};Trusted_Connection={yes};"
};

class DB {
    constructor()
    {
        connectionPool = new sql.ConnectionPool(config).connect().then(pool =>
        {
          console.log('Connected to MSSQL')
          return pool
        }).catch(err => console.log('Connection Failed: ', err));
    }

    Get(tab, end, start, order)
    {
        console.log(`Exec ${tab} ${order} ${end}, ${start}`);
        return connectionPool.then(pool => pool.query(`Exec ${tab} ${order} ${end}, ${start}`));
    }

    Exp_Imp(exec)
    {
        console.log(`Exec ${exec}`);
        return connectionPool.then(pool => pool.query(`Exec ${exec}`));
    }

    Login(log, pass)
    {
      return connectionPool.then(pool => pool.query(`Exec Login ${log}, ${pass}`));
    }

    Control_DB(exec, param)
    {
      console.log(`Exec ${exec} ${param}`);
      return connectionPool.then(pool => pool.query(`Exec ${exec} ${param}`));
    }
}

module.exports = DB;

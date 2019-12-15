const sql = require('mssql/msnodesqlv8');

let connectionPool;
const config =
{
    "driver": "msnodesqlv8",
    "connectionString": "Driver={SQL Server Native Client 11.0};Server={DESKTOP-U4BLHC6};Database={master};Trusted_Connection={yes};"
};

class ImportDB {
    constructor()
    {
        connectionPool = new sql.ConnectionPool(config).connect().then(pool =>
        {
          console.log('Connected to master MSSQL')
          return pool
        }).catch(err => console.log('Connection Failed: ', err));
    }

    Exp_Imp(exec)
    {
        console.log(`Exec ${exec}`);
        return connectionPool.then(pool => pool.query(`Exec ${exec}`)).then(pool => pool.close());
    }
}

module.exports = ImportDB;

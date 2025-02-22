new MySQL:sqlConn;


#define SQL_HOST                "localhost"
#define SQL_USER                "root"
#define SQL_PASS                ""
#define SQL_DB                  "AltheaProject"


stock bool:mysqlSetupConnection() 
{
    if(sqlConn != MYSQL_INVALID_HANDLE) return 1; // skip duplicate connection

    new MySQLOpt: opt = mysql_init_options();

    mysql_set_option(opt, AUTO_RECONNECT, true);
    sqlConn = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB, opt);
    if(mysql_errno(sqlConn != 0) || MYSQL_INVALID_HANDLE)  {

        static catchError[128];
        mysql_error(catchError);
        printf("MySQL Connection Failed: %s\n", catchError);
        return false;
    }
    else print("MySQL Connection successfully estabilished");
    return true;
}     
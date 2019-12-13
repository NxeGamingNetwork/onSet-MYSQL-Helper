-- Copyright by JanHolger

local function readFile(name)
    local fh = io.open(name, "r")
    if fh == nil then
        return nil
    end
    fh:close()
    local content = ""
    for line in io.lines(name) do
        content = content..line
    end
    return content
end

local function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

local dbConfig = {
    host = "localhost",
    username = "changeme",
    password = "changeme",
    database = "changeme"
}


if file_exists("mysqlclass.json") then
    local dbJson = ""
    for line in io.lines("mysqlclass.json") do
        dbJson = dbJson..line
    end
    dbConfig = json_decode(dbJson)
else
    local fh = io.open("mysqlclass.json","w")
    fh:write(json_encode(dbConfig))
    fh:close()
    print("The database hasn't been configured! Edit mysqlclass.json and start the server again!")
    ServerExit()
end

_G.db = mariadb_connect(dbConfig.host, dbConfig.username, dbConfig.password, dbConfig.database)
if(_G.db ~= false) then
    print("MariaDB running and connected...")
else
    print("Something went wrong with MariaDB, check out mariadb_log file...")
    ServerExit() 
end

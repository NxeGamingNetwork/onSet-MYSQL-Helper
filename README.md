# Onset MYSQL (MariaDB) Helper

Attention: Need to be Testet in Production mode. 

MYSQL (MariaDB) Insert
```
vuls = {
    ['steam_id'] = "123156456445623321",
    ['name'] = 'HansPeter Wurst'
}

insert("players", vuls)

```
MYSQL (MariaDB) DELETE
```

vuls = {
    ['steam_id'] = "123156456445623321",
    ['name'] = 'HansPeter Wurst'
}
where(vuls) -- Optional
delete("players")

```
MYSQL (MariaDB) get
```
what = {
    ['id'] = 6,
    ['steam_id'] = "1231321321313"
}
where(what) -- Optional
getPlayerData = get("players") -- Return Array
```

MYSQL (MariaDB) update
```
vuls = {
    ['steam_id'] = "123456987"
}
set = {
    ['role'] = "ADMIN",
    ['name'] = "ONYSA",
}
where(vuls) -- Optional
update("players", set)
```
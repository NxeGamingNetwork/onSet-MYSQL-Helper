# Onset MYSQL (MariaDB) Helper

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

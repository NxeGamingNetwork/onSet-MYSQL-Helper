_G.wherec = nil
_G.rowC = {}

function where(clausArry)
         clause = ""
         first = 0

         if type(clausArry) == "table" then
             --print(clausArry.length)
             --print("############### TABLE  START ###############")
             for key,value in next,clausArry,nil do
               -- print(key,value)

               if first > 0 then
                    clause = clause.. " AND "..key.."='"..value.."'"
               else
                    clause = clause..key.."='"..value.."' "
               end


                first = first+1
             end
             -- print("############### TABLE  END ###############")
         else
            return nil
         end
         _G.wherec = clause


end
function delete(table)
    if _G.wherec == nil then 
        clause = 'DELETE FROM' ..table
        print(" [DEBUG CLAUSE] "..clause)

        local result = mariadb_await_query(_G.db, clause..";")

        mariadb_delete_result(result)
        return true;
    elseif type(table) == "string" and _G.wherec ~= nil then
         clause = 'DELETE FROM ' ..table.." WHERE ".._G.wherec
         print(" [DEBUG CLAUSE] "..clause)

         local result = mariadb_await_query(_G.db, clause..";")

         mariadb_delete_result(result)
         return true;

     else
        return false
     end
end
function update(table, values)
    if type(values) == "table" then
        first = 0
        last = 0
        for _ in pairs(values) do last = last + 1 end

        clause = "UPDATE ".. table.." SET"
        for key,value in next,values,nil do
            
            
            if first+1 == last then 
                clause = clause.." "..key.."='"..value.."' "
            else
                clause = clause.." "..key.."='"..value.."', "
            end
            first = first+1
            
        end

        if _G.wherec == nil then
            clause = clause
        else
            clause = clause.." WHERE ".._G.wherec
            
        end

        local result = mariadb_await_query(_G.db, clause..";")
        
    else
        return nil
    end
end
function insert(table, values)
    if type(values) == "table" then

        first = 0
        last = 0
        for _ in pairs(values) do last = last + 1 end
        valuekeys_set = "("
        insetvals_set = "("
        clause = "INSERT INTO ".. table
        for key,value in next,values,nil do

            
            if first+1 == last then 
                valuekeys_set = valuekeys_set.."`"..key.."`"..")"
            else 
                valuekeys_set = valuekeys_set.."`"..key.."`"..","
            end 

            if first+1 == last then 
                insetvals_set = insetvals_set.."'"..value.."'"..")"
            else 
                insetvals_set = insetvals_set.."'"..value.."'"..","
            end 

             first = first+1
        end
        clause = clause.." ".. valuekeys_set .. " VALUES ".. insetvals_set
        local result = mariadb_await_query(_G.db, clause..";")
        
    else
        return nil
    end
end

function get(table, --[[optional]]select)

    if select == nil then
        select = "*"
    end


     if type(select) == "string" and _G.wherec == nil then
        clause = 'SELECT '..select.." FROM "..table

   
        local result = mariadb_await_query(_G.db, clause..";")
        if mariadb_get_row_count() ~= 0 then
           row = mariadb_get_assoc(result);

        end
        mariadb_delete_result(result)
        _G.wherec = nil

        return row;

     elseif type(select) == "string" and _G.wherec ~= nil then
         clause = 'SELECT '..select.." FROM "..table.." WHERE ".._G.wherec

         local result = mariadb_await_query(_G.db, clause..";")
         if mariadb_get_row_count() ~= 0 then
            row = mariadb_get_assoc(result);

         end
         mariadb_delete_result(result)
         _G.wherec = nil

         return row;
     else
        return false
     end
end



AddFunctionExport("get", get)
AddFunctionExport("where", where)
AddFunctionExport("insert", insert)
AddFunctionExport("delete", delete)
AddFunctionExport("update", update)
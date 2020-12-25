
convert = loadClass {
    __init__ = function(self)
        self.history = {}
    end;

    encode = function(tbl, renderDOM)
        self = self or convert
        local encodedStr = "h(";

        local lastTable = tbl
        local forwardElement = false

        local parentRoot = 0
        encodedStr = encodedStr.."'"..lastTable[1].."', {"..self:seperate(lastTable[2]).."},"
        if type(lastTable[3]) == "table" then
            encodedStr = encodedStr.."\n"
            while lastTable[3] do
                if not lastTable[3] then
                    break
                end
                local firstTable = lastTable
                local newTable = lastTable[3]
                if type(newTable[3]) == "table" then

                    for index, value in ipairs(newTable) do
                        encodedStr = encodedStr.."h(";
                        encodedStr = encodedStr.."'"..value[1].."', {"..self:seperate(value[2]).."},\n"
                    end
                    
                    
                    forwardElement = "table"
                    parentRoot = parentRoot + 1

                    lastTable = newTable
                else
                    encodedStr = encodedStr.."h(";
                    encodedStr = encodedStr.."'"..newTable[1].."', {"..self:seperate(newTable[2]).."}, '"..newTable[3].."')\n"
                    forwardElement = "string"

                    if type(firstTable[3]) == "table" and type(newTable[3]) == "string" then
                        for i=0, parentRoot do
                            encodedStr = encodedStr.."),\n"
                        end
                    end
                    
                    lastTable = newTable
                    break
                end
                
            end
        else
            
            encodedStr = encodedStr.."'"..lastTable[3].."')\n"
        end
        
        encodedStr = encodedStr.."'"..renderDOM.."');";

        outputConsole(encodedStr)
    end;

    seperate = function(self, table)
        self = self or convert
        local seperatedStr = "";

        for attrName, attrValue in pairs(table) do
            if seperatedStr == "" then
                seperatedStr = attrName..": '"..attrValue.."'"
            else
                seperatedStr = seperatedStr.." "..attrName..": '"..attrValue.."'"
            end
        end
        return seperatedStr;
    end;

    decode = function(self, string)
        self = self or convert
    end;
}

convert.encode(
    {'div', {class='main', id='main'}, {

            {'div', {class= 'nav'}, {

                    {'div', {class= 'item'}, {
                            {'a', {href= '#'}, 'Home'},
                            {'a', {href= '#'}, 'Contact Us'}
                        }
                    }

                }

            }

        }
    },
    '#render'
);
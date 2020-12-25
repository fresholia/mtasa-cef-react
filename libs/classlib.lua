function loadClass(tbl)
    setmetatable(tbl, {
        __call = function(cls, ...)
            local self = {}
            setmetatable(self, {
                __index = cls
            })

            self:__init__(...)

            return self
        end
    })

    return tbl
end
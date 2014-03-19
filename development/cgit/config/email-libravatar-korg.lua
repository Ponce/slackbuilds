local md5 = require("md5")

function filter_open(email, page)
        buffer = ""
        hexdigest = md5.sumhexa(email:sub(2, -2):lower())
end

function filter_close()
        html("<span class='libravatar'><img class='inline' src='//seccdn.libravatar.org/avatar/" .. hexdigest .. "?s=13&d=retro' /><img class='onhover' src='//seccdn.libravatar.org/avatar/" .. hexdigest .. "?s=128&d=retro' /></span>" .. buffer)
        return 0
end

function filter_write(str)
        buffer = buffer .. str
end

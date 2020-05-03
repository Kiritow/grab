local serialization=require('serialization')
local filesystem=require('filesystem')
local shell=require('shell')
local logd = GRAB_INFO.liblog.logd

local function meta_read()
    local f, err = io.open("/etc/grab/meta.cache","rb")
    if not f then
        f, err = io.open("")
    end
    local content = f:read("a")
end

local function meta_detect()
    -- Try make directory
    local ret, err = filesystem.makeDirectory("/etc/grab")
    if not ret then
        logd(err)
    end

    ret = filesystem.exists("/etc/grab/fs.check")
    if ret then
        local f, err = io.open("/etc/grab/fs.check")
        if f then
            f:close()
            return "/etc/grab"
        end
        logd(err)
    end
    local f, err = io.open('/etc/grab/fs.check', 'w')
    if f then
        f:write('success')
        f:close()
        return "/etc/grab"
    end
    logd(err)

    local cwd = shell.getWorkingDirectory()
    local check_path = filesystem.concat(cwd, "fs.check")
    ret = filesystem.exists(check_path)
    if ret then
        local f, err = io.open(check_path)
        if f then 
            f:close()
            return cwd
        end
        logd(err)
    end
    local f, err = io.open(check_path, "w")
    if f then
        f:write("success")
        f:close()
        return cwd
    end
    logd(err)

    ret = filesystem.exists("/tmp/fs.check")
    if ret then
        local f, arr = io.open("/tmp/fs.check")
        if f then
            f:close()
            return "/tmp"
        end
        logd(err)
    end
    local f, arr = io.open("/tmp/fs.check", "w")
    if f then
        f:write("success")
        f:close()
        return "/tmp"
    end
    logd(err)

    error('no available homepath found.')
end

local function meta_write(info)

end

local function meta_update(options)

end

local function meta_clean(options)
    local root = GRAB_INFO.home
    local ok, err = filesystem.remove(filesystem.concat(root, "meta.cache"))
    if not ok then
        logd(err)
    end
end

return {
    update = meta_update,
    clean = meta_clean,
    detect = meta_detect
}

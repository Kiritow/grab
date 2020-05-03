local function split(s, delim)
    local result = {}
    local from  = 1
    local delim_from, delim_to = string.find(s, delim, from  )
    while delim_from do
      table.insert(result, string.sub(s, from , delim_from-1 ))
      from  = delim_to + 1
      delim_from, delim_to = string.find(s, delim, from)
    end
    table.insert(result, string.sub(s, from))
    return result
end

local function log_debug(...)
    local trace = debug.traceback()
    trace = split(trace, "\n\9")
    trace = split(trace[3], " ")
    trace = string.gsub(trace[2], '"', '')
    trace = string.gsub(trace, ']', '')
    trace = string.sub(trace, 1, string.len(trace)-1)
    io.write("[" .. trace .. "]: ")
    print(...)
end

return {
    logd = log_debug
}

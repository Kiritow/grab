local function help_topic(topic)
    if topic == "clean" then
        return [==[Usage:
    grab clean
Clean package cache.]==]
    elseif topic == "update" then
        return [==[Usage:
    grab update
Update package cache.]==]
    elseif topic == "install" then
        return [==[Usage:
    grab install <PackageName> [PackageName2, ...]
Install packages. Dependencies will be installed automatically.]==]
    elseif topic == "remove" then
        return [==[Usage:
    grab remove <PackageName> [PackageName2, ...]
Remove packages. Dependencies will NOT be removed automatically.]==]
    elseif topic == "autoremove" then
        return [==[Usage:
    grab autoremove
Remove unused packages.]==]
    elseif topic == "add" then
        return [==[Usage:
    grab add <ProviderURL>
Add 3rd party package provider.]==]
    elseif topic == "list" then
        return [==[Usage:
    grab list [--installed]
List packages.]==]
    elseif topic == "search" then
        return [==[Usage:
    grab search <PackageName>
Search packages by name.]==]
    else
        return ""
    end
end

return {
    topic = help_topic
}

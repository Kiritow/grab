# -*- coding: utf-8 -*-

with open("grab_main.lua") as f:
    content = f.read()

output = []

for line in content.replace('\r', '').split('\n'):
    if "-- #include" in line:
        filename, varname = line.split('-- #include')[1].split()
        print "Found include tag: {} as {}".format(filename, varname)
        with open(filename) as f:
            content = f.read()
        output.append("local {}=load([=====[{}]=====], '{}')()".format(varname, content, filename))
    else:
        output.append(line)

with open("grab.lua", "w") as f:
    f.write('\n'.join(output))

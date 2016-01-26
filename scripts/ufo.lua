
assert(os.execute(), "No shell available")

local cmd = {}

local dirs = {
  'externals', 'activities', 'infra', 'domain', 'resources', 'assets'
}

local function sys (verbose, str, ...)
  local line = str:format(...)
  if verbose then
    print("[ufo]\t"..line)
  end
  assert(os.execute(line))
end

local function writeTemplate (inpath, outpath, env)
  local macro = require 'lux.macro'
  inpath = string.format("scripts/templates/%s", inpath)
  local template = io.open(inpath, 'r')
  assert(template, "Failed to load template "..inpath)
  local output = io.open(outpath, 'w')
  print("[ufo]\t+new file: "..outpath)
  return output:write(macro.process(template:read('a'), env))
end

function cmd.setup ()

  print("[ufo] Creating basic project structure...")
  for _,dir in ipairs(dirs) do
    sys(true, "mkdir %s", dir)
  end

  print("[ufo] Downloading framework...")
  sys(false, "cd externals && git clone https://github.com/Kazuo256/luxproject.git")
  sys(false, "cd externals && git clone https://github.com/Kazuo256/ufoproject.git -b infra_domain_activity")
  
  cmd.update()

  print("[ufo] Generating standard template...")
  writeTemplate("conf.in.lua", "conf.lua")
  writeTemplate("main.in.lua", "main.lua")
  writeTemplate(".gitignore.in", ".gitignore")
  writeTemplate("Activity.in.lua", "activities/BootstrapActivity.lua",
                { name = "Bootstrap" })

end

function cmd.update ()
  print("[ufo] Updating LUX...")
  sys(false, "cd externals/luxproject && git pull")
  sys(false, "cp -r externals/luxproject/lib/lux .")
  
  print("[ufo] Updating UFO...")
  sys(false, "cd externals/ufoproject && git pull")
  sys(false, "cp -r externals/ufoproject/lib/ufo .")
  sys(false, "cp -r externals/ufoproject/scripts .")
end

local command = ...

cmd[command]()

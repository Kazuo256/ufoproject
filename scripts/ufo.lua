
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

local function writeTemplate (which, id, opt)
  local macro = require 'lux.macro'
  -- Load template
  local inpath = string.format("scripts/templates/%s.in.lua", which)
  local template = io.open(inpath, 'r')
  local env = { id = id, opt = opt }
  assert(template, "Failed to load template "..inpath)
  -- Process
  local generated = macro.process(template:read('a'), env)
  assert(env.outfmt, "Template is missing its output format")
  local outpath = env.outfmt:format(id)
  -- Write output
  local output = io.open(outpath, 'w')
  print("[ufo]\t+generated: "..outpath)
  return output:write(generated)
end

function cmd.setup ()

  print("[ufo] Creating basic project structure...")
  for _,dir in ipairs(dirs) do
    sys(true, "mkdir %s", dir)
  end

  print("[ufo] Downloading framework...")
  sys(false,
      "cd externals && git clone https://github.com/Kazuo256/luxproject.git")
  sys(false,
      "cd externals && git clone https://github.com/Kazuo256/ufoproject.git")
  
  cmd.update()

  print("[ufo] Generating standard template...")
  writeTemplate("conf")
  writeTemplate("main")
  writeTemplate(".gitignore")
  writeTemplate("activity", "Bootstrap")

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

function cmd.generate (template, ...)
  local template, name = arg[2], arg[3]
  writeTemplate(template, name) 
end

return cmd[arg[1]] (select(2, ...))

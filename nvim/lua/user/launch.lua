LAZY_PLUGIN_SPEC = {}

function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

function prprp()
  print(LAZY_PLUGIN_SPEC)
end

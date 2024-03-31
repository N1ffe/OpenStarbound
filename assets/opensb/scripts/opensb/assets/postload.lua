-- Revert cursor frames if a mod replaced cursors.png with a SD version again
if assets.image("/cursors/cursors.png"):size()[1] == 64 then
  local path = "/cursors/opensb/revert.cursor.patch"
  assets.add(path, '{"scale":null}')
  assets.patch("/cursors/inspect.cursor", path)
  assets.patch("/cursors/link.cursor", path)
  assets.patch("/cursors/pointer.cursor", path)
  path = "/cursors/opensb/revert.frames.patch"
  assets.add(path, '{"frameGrid":{"size":[16,16]}}')
  assets.patch("/cursors/cursors.frames", path)
end

-- Add object patches
local objects = assets.byExtension("object")
local path = "/objects/opensb/object.patch.lua"
for i = 1, #objects do
  assets.patch(objects[i], path)
end

-- Add item asset sources
local itemExtensions = {
  "item",
  "liqitem",
  "matitem",
  "miningtool",
  "flashlight",
  "wiretool",
  "beamaxe",
  "tillingtool",
  "painttool",
  "harvestingtool",
  "head",
  "chest",
  "legs",
  "back",
  "currency",
  "consumable",
  "blueprint",
  "inspectiontool",
  "instrument",
  "thrownitem",
  "unlock",
  "activeitem",
  "augment",
  "object"
}
for _, extension in ipairs(itemExtensions) do
  for _, path in ipairs(assets.byExtension(extension)) do
    local item = assets.json(path)
    local metadata = assets.source(path)
    if item.description and metadata.name ~= "base" then
      item.description = string.format("%s\n^#a3a3a3;[%s]^reset;", item.description, metadata.friendlyName)
    end
    assets.add(path, item)
  end
end
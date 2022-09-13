- [new](#new)
- [setEventOnLoad](#setEventOnLoad)
- [setEventPreLoad](#setEventPreLoad)
- [setEventUnLoad](#setEventUnLoad)
- [setEventInit](#setEventInit)
- [setSetting](#setSetting)
- [setMapBySize](#setMapBySize)
- [generateMap](#generateMap)
- [getIdBlockGen](#getIdBlockGen)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)

## new

```lua
new(tilemap, BlockList, events)
```

is in charge of managing functions that are related to the map, and the blocks

```lua
 Map(tilemap, BlockList, events)
```

| Input | Type | Description |
| --- | --- | --- |
| `Map` | `table` | simple tilemap |

| Input | Type | Description |
| --- | --- | --- |
| `BlockList` (optional) | `BlockList` | map use global Block list but can set own block list |

| Input | Type | Description |
| --- | --- | --- |
| `events` (optional) | `table` | set callbacks event |

| Output type | Description |
| --- | --- |
| `Map` | return self |

## setEventOnLoad

```lua
setEventOnLoad(function)
```

set callback event

```lua
 Map:setEventOnLoad(f)
```

| Input | Type | Description |
| --- | --- | --- |
| `f` | `function` | set callback for event onLoad  |


## setEventPreLoad

```lua
setEventPreLoad(function)
```

set callback event

```lua
 Map:setEventPreLoad(f)
```

| Input | Type | Description |
| --- | --- | --- |
| `f` | `function` | set callback for event preLoad  |


## setEventUnLoad

```lua
setEventUnLoad(function)
```

set callback event

```lua
 Map:setEventUnLoad(f)
```

| Input | Type | Description |
| --- | --- | --- |
| `f` | `function` | set callback for event unLoad  |


## setEventInit

```lua
setEventInit(function)
```

set callback event

```lua
 Map:setEventInit(f)
```

| Input | Type | Description |
| --- | --- | --- |
| `f` | `function` | set callback for event Init  |


## setSetting

```lua
setSetting(s)
```

set settings tilemap, settings is a table has values need map for build tilemap

```lua
setting = {
  tileWidth = 16,
  tileHeight = 16,
  omitZero = false --if is zero id, omit create block
}
```

```lua  
 Map:setSetting(s)
```

| Input | Type | Description |
| --- | --- | --- |
| `s` | `table` | set setting of map |

## setMapBySize

```lua
setMapBySize(width, height)
```

create map by width and height,setMapBySize to generate the map values use the function ```lua Map:getIdBlockGen() ```, Useful for procedural generation or perlin noise

```lua
 Map:setMapBySize(width, height)
```

| Input | Type | Description |
| --- | --- | --- |
| `width` | `init` | width of the map |
| `height` | `init` | height of the map |

## generateMap

```lua
generateMap(width, height)
```

a function that has the objective of restarting the generation of the map, without having to create a new map, it only changes the values of the original map,generateMap to generate the map values use the function ```lua Map:getIdBlockGen() ```

```lua
 Map:generateMap(width, height)
```

| Input | Type | Description |
| --- | --- | --- |
| `width` (optional) | `init` | width of the map |
| `height` (optional) | `init` | height of the map |

## getIdBlockGen

```lua
getIdBlockGen(tx, ty)
```

is a function that is used to generate the map tile in the functions generateMap, setMapBySize.replace the function with one that is suitable for the generation of tiles you are looking for

the output must be an int value, from that value a block with the same id is associated, if the id is not valid, it is replaced by 0

```lua
 Map:getIdBlockGen( tx, ty)
```


| Input | Type | Description |
| --- | --- | --- |
| `tx` | `init` | tile position x |

| Input | Type | Description |
| --- | --- | --- |
| `ty` | `init` | tile position y |

| Output type | Description |
| --- | --- |
| `init` | return id block |



## Map

```lua
Map:toTile(x, y)
```

 World coords to tile coords

```lua
 Map:toTile(x, y)
```


| Input | Type | Description |
| --- | --- | --- |
| `x` | `float` | world position x |

| Input | Type | Description |
| --- | --- | --- |
| `y` | `float` | world position y |

| Output type | Description |
| --- | --- |
| `init` | return tx, ty |



## Map

```lua
Map:tileTo(tx, ty)
```

 tile coords to world coords

```lua
 Map:tileTo(tx, ty)
```


| Input | Type | Description |
| --- | --- | --- |
| `tx` | `init` | tile position x |

| Input | Type | Description |
| --- | --- | --- |
| `ty` | `init` | tile position y |

| Output type | Description |
| --- | --- |
| `float` | return x, y |



## Map

```lua
Map:setBlock(obj, tx, ty, forzePlace)
```

 Set block in map, this function needs the maptile to be already loaded

```lua
 Map:setBlock(obj, tx, ty, forzePlace)
```


| Input | Type | Description |
| --- | --- | --- |
| `obj` | `init` | is value id block, can be number id |

| Input | Type | Description |
| --- | --- | --- |
| `obj` | `table` | can be table has {id, data = {}} |

| Input | Type | Description |
| --- | --- | --- |
| `tx` | `init` | tile position x |

| Input | Type | Description |
| --- | --- | --- |
| `ty` | `init` | tile position y |

| Input | Type | Description |
| --- | --- | --- |
| `forzePlace` (optional) | `bool` | if is true, place block even when the space is already occupied |


## Map

```lua
Map:getBlock(tx, ty)
```

 to get blocks on the map, this function needs the maptile to be already loaded

```lua
 Map:getBlock(tx, ty)
```

| Input | Type | Description |
| --- | --- | --- |
| `tx` | `init` | tile position x |

| Input | Type | Description |
| --- | --- | --- |
| `ty` | `init` | tile position y |

| Output type | Description |
| --- | --- |
| `Block` | return Block object |

## Map

```lua
Map:removeBlock(tx, ty)
```

 remove blocks on the map, this function needs the maptile to be already loaded

```lua
 Map:removeBlock(tx, ty)
```

| Input | Type | Description |
| --- | --- | --- |
| `tx` | `init` | tile position x |

| Input | Type | Description |
| --- | --- | --- |
| `ty` | `init` | tile position y |

## Map

```lua
Map:load(x, y)
```

 load the map to use this

```lua
 Map:load(x, y)
```

| Input | Type | Description |
| --- | --- | --- |
| `x` | `init` | world position x |

| Input | Type | Description |
| --- | --- | --- |
| `y` | `init` | world position y |

## Map

```lua
Map:update(dt)
```

  Update Map

```lua
 Map:update(dt)
```

| Input | Type | Description |
| --- | --- | --- |
| `dt` | `deltaTime` | TODO |

## Map

```lua
Map:draw()
```

  draw Map

```lua
 Map:draw()
```

## Map

```lua
Map:close()
```

  close map, destroy all object are in map

```lua
 Map:close()
```

## Map

```lua
Map:reset()
```

  it is to reset the map

```lua
 Map:reset()
```
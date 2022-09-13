- [new](#new)
- [setEventOnLoad](#setEventOnLoad)
- [setEventPreLoad](#setEventPreLoad)
- [setEventOnLoad](#setEventOnLoad)
- [setEventInit](#setEventInit)

## new

```lua
new(tilemap, BlockList, events)
```

```lua
 Map(tilemap, BlockList, events)
```

is in charge of managing functions that are related to the map, and the blocks

| Input | Type | Description |
| --- | --- | --- |
| `first` | `table` | simple tilemap |

| Input | Type | Description |
| --- | --- | --- |
| `optional` (optional) | `BlockList` | map use global Block list but can set own block list |

| Input | Type | Description |
| --- | --- | --- |
| `optional` (optional) | `table` | set callbacks event |

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

apply

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event preLoad  |


## setEventOnLoad

```lua
setEventOnLoad(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event onLoad  |


## setEventInit

```lua
setEventInit(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event Init  |

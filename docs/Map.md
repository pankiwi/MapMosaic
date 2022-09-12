- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)
- [Map](#Map)

## Map

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

## Map

```lua
Map:setEventOnLoad(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event onLoad  |


## Map

```lua
Map:setEventPreLoad(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event preLoad  |


## Map

```lua
Map:setEventOnLoad(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event onLoad  |


## Map

```lua
Map:setEventInit(function)
```

| Input | Type | Description |
| --- | --- | --- |
| `first` | `function` | set callback for event Init  |

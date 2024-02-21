Tuples
```bash
> [for w in var.worlds : upper(w)]
[
  "MERCURY",
  "VEMUS",
  "EARTH",
  "MARS",
]
>
```
```bash
> {for k, v in var.worlds : "${k}" => upper(v)}
{
  "0" = "MERCURY"
  "1" = "VEMUS"
  "2" = "EARTH"
  "3" = "MARS"
}
>
```

Maps
```bash
> [for k, v in var.worlds_map : upper(k)]
[
  "EARTH",
  "MARS",
  "MERCURY",
  "VEMUS",
]
>
```

Splat
```bash
> var.worlds_splat
tolist([
  {
    "planet_name" = "mercury"
    "planet_num" = "one"
  },
  {
    "planet_name" = "vemus"
    "planet_num" = "two"
  },
  {
    "planet_name" = "earth"
    "planet_num" = "three"
  },
  {
    "planet_name" = "mars"
    "planet_num" = "four"
  },
])
>
```
```bash
> var.worlds_splat[*].planet_name
tolist([
  "mercury",
  "vemus",
  "earth",
  "mars",
])
>
```

# Observatory field notes

Notes from the autumn session. The catalogue lives in `catalogue.json` and the
tracker reads it with `Observatory.track()`.

## Equipment

- 8 inch reflector on an **equatorial** mount
- 4 inch refractor on an *alt-az* mount
  - finder scope realigned on Vega
  - dew heater on the secondary

### Targets for tonight

1. Sirius, low in the south before dawn
2. Andromeda galaxy, best around midnight
3. The Pleiades, for the wide-field test

#### Checklist

- [x] Collimate the reflector
- [x] Charge the mount battery
- [ ] Update the star chart from the [catalogue repo](https://example.com/catalogue)
- [ ] Log seeing conditions every hour

##### Seeing scale

| Score | Meaning               |
| ----- | --------------------- |
| 1     | Stars boil, no focus  |
| 3     | Usable for planets    |
| 5     | Steady, split doubles |

###### Footnote on magnitudes

> Apparent magnitude runs backwards: smaller numbers are brighter.
> Sirius sits at `-1.46`, which is why it sorts first.

The light delay is computed like this:

```ts
const km = body.distance * 1.496e8;
return Math.round(km / LIGHT_SPEED);
```

See <https://example.com/orbits> for the derivation, or read
[the orbit notes][orbits] if you are offline.

---

Last updated by the night shift. ~~Moon phase was wrong.~~ Fixed.

[orbits]: ./orbits.md

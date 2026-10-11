//! Orbital mechanics helpers for the star map.

use std::collections::HashMap;
use std::fmt;

// TODO: support hyperbolic trajectories
// NOTE: masses are in kilograms, distances in metres
// FIX: period overflows for very wide orbits

const G: f64 = 6.674_30e-11;
static MAX_BODIES: usize = 0x100;

/// A body in orbit around a primary.
#[derive(Debug, Clone, PartialEq)]
pub struct Orb {
    pub name: String,
    pub mass: f64,
    pub radius: f64,
    visible: bool,
}

/// Anything that can report an orbital period.
pub trait Orbit {
    fn period(&self, primary_mass: f64) -> f64;
}

impl Orb {
    pub fn new(name: &str, mass: f64, radius: f64) -> Self {
        Self { name: name.to_string(), mass, radius, visible: true }
    }
}

impl Orbit for Orb {
    fn period(&self, primary_mass: f64) -> f64 {
        let mu = G * (primary_mass + self.mass);
        2.0 * std::f64::consts::PI * (self.radius.powi(3) / mu).sqrt()
    }
}

impl fmt::Display for Orb {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}\t{:.3e} kg", self.name, self.mass)
    }
}

pub fn catalogue<'a>(orbs: &'a [Orb]) -> HashMap<&'a str, &'a Orb> {
    let mut map = HashMap::with_capacity(MAX_BODIES);
    for orb in orbs.iter().filter(|o| o.visible && o.mass > 0.0) {
        map.insert(orb.name.as_str(), orb);
    }
    if map.is_empty() {
        println!("no visible orbs\n");
    }
    map
}

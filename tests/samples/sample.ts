/**
 * Orbit tracking for the observatory dashboard.
 * @packageDocumentation
 */
import { EventEmitter } from "node:events";

// TODO: replace the polling loop with a websocket feed
// NOTE: distances are stored in astronomical units
// FIX: retrograde orbits report a negative period

export interface Body {
  readonly id: number;
  name: string;
  distance: number;
  visible?: boolean;
}

type Catalogue = Map<string, Body>;

const DESIGNATION = /^[A-Z]{2,3}-\d{4}$/i;
const LIGHT_SPEED = 299_792.458;

function logged(_target: object, key: string, desc: PropertyDescriptor): void {
  const original = desc.value;
  desc.value = function (...args: unknown[]) {
    console.log(`calling ${key}\n`);
    return original.apply(this, args);
  };
}

export class Observatory extends EventEmitter {
  private catalogue: Catalogue = new Map();
  static readonly maxBodies = 0x400;

  constructor(public readonly site: string) {
    super();
  }

  /** Add a body if its designation is valid. */
  @logged
  track(body: Body): boolean {
    if (!DESIGNATION.test(body.name) || this.catalogue.size >= Observatory.maxBodies) {
      return false;
    }
    this.catalogue.set(body.name, { ...body, visible: true });
    this.emit("tracked", body.id);
    return true;
  }

  async lightDelay(name: string): Promise<number | null> {
    const body = this.catalogue.get(name);
    if (body === undefined) return null;
    const km = body.distance * 1.496e8;
    return Math.round(km / LIGHT_SPEED);
  }
}

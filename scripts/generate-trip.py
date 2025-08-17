#!/usr/bin/env python3
import argparse
import csv
import re
import random
from datetime import datetime, timezone, timedelta
from typing import Optional

# example : python generate-trip.py -n 120 -s 10s --noise-std 0.3 --spike-prob 0.05 --spike-mag-min 3 --spike-mag-max 6 --rebound-frac 0.5 --clip-min 0 --clip-max 60 --seed 7 -o out.csv

# ----------------------------
# Parsing helpers
# ----------------------------

def parse_start(s: Optional[str]) -> datetime:
    if not s:
        return datetime.now(timezone.utc).replace(microsecond=0)
    s = s.strip()
    if s.endswith("Z"):
        return datetime.strptime(s, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)
    try:
        dt = datetime.fromisoformat(s)
    except ValueError as e:
        raise argparse.ArgumentTypeError(
            "Invalid --start. Use ISO-8601 like 2025-08-01T14:05:00Z"
        ) from e
    if dt.tzinfo is None:
        raise argparse.ArgumentTypeError("Start time must include a timezone or end with Z.")
    return dt.astimezone(timezone.utc)

def parse_step(s: str) -> int:
    m = re.fullmatch(r"\s*(\d+)\s*([smh]?)\s*", s, flags=re.IGNORECASE)
    if not m:
        raise argparse.ArgumentTypeError("Step must look like 60, 60s, 1m, or 2h.")
    n = int(m.group(1))
    unit = (m.group(2) or "s").lower()
    mult = {"s": 1, "m": 60, "h": 3600}[unit]
    seconds = n * mult
    if seconds <= 0:
        raise argparse.ArgumentTypeError("Step must be > 0.")
    return seconds

# ----------------------------
# Signal model
# ----------------------------

def mpg_baseline(_: datetime) -> float:
    """Baseline generator: constant 30.0 mpg."""
    return 4.8

def noisy_value(
    t: datetime,
    noise_std: float,
    spike_prob: float,
    spike_mag_min: float,
    spike_mag_max: float,
    rebound_frac: float,
    spike_state: dict,
    clip_min: Optional[float],
    clip_max: Optional[float],
) -> float:
    """
    Returns baseline + gaussian noise + optional spike pattern.
    Spike pattern: 2–3 decreases, then 1 increase.
    - decrease magnitude sampled in [spike_mag_min, spike_mag_max]
    - rebound magnitude = rebound_frac * decrease
    spike_state holds a queue of pending offsets (in mpg) to apply.
    """
    base = mpg_baseline(t)

    # Gaussian noise
    val = base + (random.gauss(0.0, noise_std) if noise_std > 0 else 0.0)

    # Apply continuing spike offsets if any
    queue = spike_state.get("queue", [])
    if queue:
        val += queue.pop(0)
    else:
        # Potentially start a new spike pattern
        if spike_prob > 0 and random.random() < spike_prob:
            drop = random.uniform(spike_mag_min, spike_mag_max)
            down_len = random.choice([2, 3])
            rebound = drop * rebound_frac
            queue = ([-drop] * down_len) + [rebound]
            spike_state["queue"] = queue
            val += queue.pop(0)

    # Optional clipping
    if clip_min is not None:
        val = max(clip_min, val)
    if clip_max is not None:
        val = min(clip_max, val)

    return val

# ----------------------------
# Main
# ----------------------------

def main():
    p = argparse.ArgumentParser(
        description="Generate a time,mpg CSV with noise and patterned spikes (2–3 down, then 1 up)."
    )
    # Core
    p.add_argument("-n", "--count", type=int, required=True, help="Number of points (>0).")
    p.add_argument("-s", "--step", type=parse_step, required=True, help="Time step, e.g. 60s, 1m, 2h.")
    p.add_argument("-t", "--start", type=str, default=None,
                   help="Start time (UTC) ISO-8601, e.g. 2025-08-01T14:05:00Z. Defaults to now (UTC).")
    p.add_argument("-o", "--out", type=str, default="mpg.csv", help="Output CSV filepath (default: mpg.csv).")
    p.add_argument("--seed", type=int, default=None, help="PRNG seed for reproducibility.")

    # Noise controls
    p.add_argument("--noise-std", type=float, default=0.0, help="Gaussian noise sigma in mpg (default: 0.0).")

    # Spike controls (patterned)
    p.add_argument("--spike-prob", type=float, default=0.0,
                   help="Probability of starting a spike pattern at each point (0..1).")
    p.add_argument("--spike-mag-min", type=float, default=5.0,
                   help="Min absolute magnitude of each decrease (mpg).")
    p.add_argument("--spike-mag-max", type=float, default=10.0,
                   help="Max absolute magnitude of each decrease (mpg).")
    p.add_argument("--rebound-frac", type=float, default=0.5,
                   help="Rebound magnitude as a fraction of the decrease (e.g., 0.5 => half).")

    # Optional clipping
    p.add_argument("--clip-min", type=float, default=None, help="Lower bound for mpg (optional).")
    p.add_argument("--clip-max", type=float, default=None, help="Upper bound for mpg (optional).")

    args = p.parse_args()

    if args.count <= 0:
        p.error("--count must be a positive integer.")
    if not (0.0 <= args.spike_prob <= 1.0):
        p.error("--spike-prob must be between 0 and 1.")
    if args.spike_mag_min < 0 or args.spike_mag_max < 0:
        p.error("--spike-mag-min/max must be non-negative.")
    if args.spike_mag_min > args.spike_mag_max:
        p.error("--spike-mag-min cannot exceed --spike-mag-max.")
    if args.rebound_frac < 0.0:
        p.error("--rebound-frac must be >= 0.0.")
    if (args.clip_min is not None and args.clip_max is not None
            and args.clip_min > args.clip_max):
        p.error("--clip-min cannot exceed --clip-max.")

    if args.seed is not None:
        random.seed(args.seed)

    start = parse_start(args.start)
    step = timedelta(seconds=args.step)

    spike_state = {"queue": []}

    with open(args.out, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["time", "mpg"])
        t = start
        for _ in range(args.count):
            mpg = noisy_value(
                t=t,
                noise_std=args.noise_std,
                spike_prob=args.spike_prob,
                spike_mag_min=args.spike_mag_min,
                spike_mag_max=args.spike_mag_max,
                rebound_frac=args.rebound_frac,
                spike_state=spike_state,
                clip_min=args.clip_min,
                clip_max=args.clip_max,
            )
            w.writerow([t.strftime("%Y-%m-%dT%H:%M:%SZ"), f"{mpg:.1f}"])
            t += step

if __name__ == "__main__":
    main()

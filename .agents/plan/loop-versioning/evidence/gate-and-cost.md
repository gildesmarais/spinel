# Loop versioning: `make gate`, and what it costs (base `52c5ccf74` against HEAD `4ca5b952a`)

Raw data, scripts and idle readings: [`gate-and-cost/`](gate-and-cost/).
Machine: Apple M2 MacBook Air (fanless), macOS 27.0.1, Apple clang 21.0.0.
Both compilers were built with `make -j8 all` in their own detached worktrees,
`tmp/wt-base` (`52c5ccf74`) and `tmp/wt-head` (`4ca5b952a`), each with
`vendor/` symlinked to the main checkout's.

**Status: the gate, which loops version, binary and C size, and the
benchmarks' compile time are done. The run-time comparison (benchmarks and
optcarrot) is not: from 15:10:50 the machine was on battery, and it went to
sleep at 15:11:06. Every check since then has found it on battery, and the
abort rule forbids measuring on battery.** What the size data shows already
bounds that comparison: 61 of the 64 benchmark binaries, and optcarrot's,
are byte-identical between base and HEAD, so only three benchmarks can
differ at run time (see [Run time](#run-time-not-measured)).

## `make gate` on HEAD

`make -C <repo> gate` in the main checkout: branch `simd-loops-versioning`,
HEAD `4ca5b952a`, clean tree, the default `GATE_CACHE=1`. It ran 14:28:36 to
14:56:56 +0200, **exit 0, `gate: ALL GREEN`**, `real 1700.11 s` (28 min 20 s), user 8541.91 s,
sys 1732.84 s ([`make-gate.log`](gate-and-cost/make-gate.log)). The gate
cloned `build/optcarrot` (`experiment/spinel`, `b622088c5`) and
`build/rubyspec` (pinned `79e2dee`). Its stamp, written to `.git/gate-stamp`,
is for tree `b86075cc3bcd` on master `52c5ccf74734`, `tests=6052/0`. The
commit was not amended, so it carries no `Gate:` trailer.

| Leg | Result |
| --- | --- |
| `all` | built |
| `gate-test` (`make test OPT=-O1`) | `Tests: 6052 pass, 0 fail, 0 error`. Every C-side leg passed, among them `loop-version-test`, `threaded-render-test`, `decisions-test`, `gc-stress-test` and `thread-puts-test`. RBS extractor: 15 pass |
| `gate-bench` (`make bench`) | `Benchmarks: 64 pass, 0 fail, 0 error, 0 skip` |
| `gate-optcarrot` | `checksum: 59662`, `Optcarrot: OK`. Its fps (244.8, spread 186%) was taken under the gate's own load (1-minute load up to 171) and is not a measurement |
| `gate-rubyspec` (`rubyspec-gate`) | 3,206 expected-PASS examples still pass: language 1025, core/array 665, core/string 842, core/hash 261, core/integer 213, core/range 200 |
| `gate-props` | all pass: `alloc-report-test`, `infer-test`, `collect-errors-test` (426 refusal records), `spin-check` (`spin-e2e: ALL GREEN`), `diff-test`, `bisect-test`, `traits-check-test` (52 kinds, 0 cells differ, both modes), `bop-arity-check-test` (494 + 903 rows, 0 outside), `scale-test` (1.70x / 2.50, 4.73x / 5.20, 6.07x / 6.90, 4.22x / 4.50) |

No leg failed, so nothing was rerun on base. The legs report no new failures
and no pre-existing ones.

One finding the gate does not fail on: the counting compiler's build
(`build/csrc-work`) warns at the branch's own code,
`src/codegen_stmt.c:6758`, where `nameset_has(&r->wl, nm)` passes a
`const NameSet *` to a `NameSet *` parameter
(`-Wincompatible-pointer-types-discards-qualifiers`).

## Which loops version

`spinel <prog> -c --decisions-log=<file>` with each compiler
([`emit.csv`](gate-and-cost/emit.csv), the keys in
[`decisions/`](gate-and-cost/decisions/)). Each `loop-version` key matches
one `int _lvgN = 1;` guard in the C. HEAD versions **4 loops in 3 of the 64
benchmarks**. Base versions none.

| Benchmark | Loops | Where | What runs there |
| --- | --: | --- | --- |
| `bm_matmul` | 2 | `:6:5` (matgen's init loop), `:23:7` (the kernel's inner `j` loop) | the hot kernel, at `n = 150` |
| `bm_spectral_norm` | 1 | `:63:1` | the one-shot `vbv`/`vv` reduction after the main loop; the hot loops call `eval_a` and are not cached |
| `bm_huffman` | 1 | `:135:1` | a one-shot 256-entry `freq[i] > 0` count |

None of them is chunked (`_lvcN`): `bm_threaded_render`, the only threaded
benchmark, versions nothing, so no benchmark exercises the threaded form.
For the other 61 benchmarks, HEAD's C is identical to base's except for
`#line` paths, which name each worktree (`c_identical_but_line` in
`emit.csv`). Optcarrot (`build/optcarrot-single.rb`, 4,309 lines, 125 KB of
Ruby, 1.38 MB of C) versions **no loop**, and its C is identical to base's
except for `#line` paths ([`emit-optcarrot.csv`](gate-and-cost/emit-optcarrot.csv)).

## Size and compile time

`cost.rb build 10`: 10 rounds, and in each one every benchmark builds once
per side, alternating which side builds first. A build is `spinel <prog> -c`
(the front end alone), then `spinel <prog> -o <bin>` (spinel plus cc, timed
wall clock), then `strip` on a copy. The session ran 15:00:12 to 15:10:05, on
AC power: the power-management log's last `Using AC` entry before the switch
is at 15:00:27, and its first `Using Batt` is at 15:10:50. All 1,280 builds
passed. Per program: [`build-summary.md`](gate-and-cost/build-summary.md);
every sample is in [`build.csv`](gate-and-cost/build.csv).

| Program | Loops | C bytes, base → head | `__text` bytes, base → head | stripped file | spinel+cc median ms, base / head (IQR) | head/base, MWU p |
| --- | --: | --- | --- | --- | --- | --- |
| `bm_matmul` | 2 | 28,235 → 31,409 (+3,174, **+11.2%**) | 149,532 → 150,492 (+960) | 242,552, same | 410 (51) / 403 (39) | 0.984, p 0.57 |
| `bm_spectral_norm` | 1 | 33,017 → 34,325 (+1,308, +4.0%) | 157,816 → 158,200 (+384) | 259,376, same | 430 (33) / 439 (38) | 1.022, p 0.31 |
| `bm_huffman` | 1 | 47,517 → 48,740 (+1,223, +2.6%) | 171,144 → 171,360 (+216) | 276,168, same | 482 (35) / 499 (46) | 1.035, p 0.26 |
| the other 61 | 0 | same, apart from `#line` paths | same | byte-identical | 0.955–1.051 | all within noise |
| **all 64** | 4 | 2,156,637 → 2,162,342 (+5,705, **+0.26%**) | +1,560 in total | 16,656,976, same (+0) | Σ medians 27,515 → 27,570 (+0.20%) | 64 of 64 within noise |
| optcarrot | 0 | 1,380,717, same apart from `#line` | 838,864, same | 992,832, byte-identical | ~5,050 / ~5,050 (indicative, see below) | — |

- **Binary size:** 0 bytes on disk. The growth is in `__text` (`size -m`) and
  stays inside the 16 KB arm64 page that `__TEXT` is rounded to, so every
  stripped file keeps its size. 62 of the 65 stripped binaries (64 benchmarks
  plus optcarrot) are byte-identical between base and HEAD, and unstripped
  as well.
- **Compile time:** the per-program IQR is 20–92 ms (about 5–10%), and no
  program's difference is outside it (IQRs overlap; Mann–Whitney p ≥ 0.26 for
  the three that changed). The front end alone (`spinel -c`) takes 5–48 ms
  per benchmark and reads the same on both sides to the millisecond. The
  +0.20% of the summed medians is noise: 61 of the 64 programs compile
  identical C.
- **Optcarrot compile time:** its own session started at 15:10:05 and ran
  into the unplug at about 15:10:50 and the sleep at 15:11:06. Rounds 6–9
  hold samples of 10.8 s to 1,934 s, and round 10 ran on battery after the
  wake at 16:16:54. All of those samples are void
  ([`build-optcarrot-aborted.csv`](gate-and-cost/build-optcarrot-aborted.csv)).
  Rounds 1–4 were done near or before the unplug: base 4,975–5,086 ms, head
  5,014–5,235 ms, and `spinel -c` 558–588 ms against 562–591 ms. With
  identical C, only spinel's own time could differ, and it does not
  measurably. The re-run on AC power never got its window.

## Run time (not measured)

The harness is in place (`cost.rb run r1` with `ROUNDS=30`: base and head
interleaved, two warm-up rounds, every sample recorded, an AC check before
and after each benchmark; then `cost.rb fps r1 20` for optcarrot), but it never ran.
Every pre-session check found the machine on battery (attempts at 16:31,
16:43 and 18:06), and the abort rule stopped each one before its first
sample. `probe.csv` is only the output check: every benchmark binary on both
sides printed its `.expected` text. The single times next to each result are
unsupervised, and were taken while the power kept switching, so they are not
measurements.

What is known without measuring:

- 61 benchmark binaries and the optcarrot harness binary (the Makefile's
  recipe: `--no-line-map`, `-DSP_INT_OVERFLOW_MODE_WRAP`) are byte-identical
  between base and HEAD. For them, base against head can only read noise.
- `bm_spectral_norm`'s and `bm_huffman`'s versioned loops run once, over `n`
  and over 256 elements. Neither is on a hot path.
- `bm_matmul` is the only benchmark whose hot loop changed. Its kernel was
  measured in Phase 03 (r1/r2: 10.4x at `n = 500`). At the shipped
  `n = 150`, process start-up dominates (2.6 ms of about 3–4 ms).

To resume on AC power (the worktrees and `tmp/gc/` are left in place):

```sh
caffeinate -i sh -c 'S=tmp/gc/cost.rb; ruby $S idle run1-before && ROUNDS=30 ruby $S run r1 && ruby $S fps r1 20 && ruby $S idle run1-after && ruby $S idle build2-before && ruby $S build 10 tmp/gc/optcarrot-single.rb && ruby $S idle build2-after'
ruby tmp/gc/analyze.rb run r1; ruby tmp/gc/analyze.rb optcarrot tmp/gc/fps-r1.csv
```

## Idle readings

Taken by `cost.rb idle` (`uptime`, `top -l 2 -o cpu -n 10 -s 1`,
`pmset -g batt`, `pmset -g therm`, low power mode), in
[`gate-and-cost/idle/`](gate-and-cost/idle/). Abort rule: not on AC power, a
CPU speed limit, low power mode, any process at 80% CPU or more, or a
build/indexing process at 5% or more. A high load average alone does not
abort.

| When (+0200) | load 1/5/15 | CPU idle | top consumers (%CPU) | power, thermal | verdict |
| --- | --- | --: | --- | --- | --- |
| 14:57:36, after the gate | 40.20 95.99 90.27 | 79.3% | OrbStack Helper 10.9, top 7.8, kernel_task 5.9 | AC; no thermal, performance or CPU-power warning; LPM 0 | OK (the load was still decaying from the gate) |
| 15:00:12, before the build session | 4.77 57.92 75.56 | 81.7% | WindowServer 37.7, Cursor Helper 23.5, kernel_task 15.7 | same | OK |
| 16:17:19, after (woken from sleep) | 66.49 28.76 42.10 | 44.0% | PosterBoard 73.9, pmset 58.3, fseventsd 30.4 | battery | ABORT |
| 16:31:20, run session, attempt 1 (not kept on disk) | 1.84 8.80 25.54 | 66.7% | WindowServer 36.2, kernel_task 29.3, OrbStack Helper 16.8 | battery | ABORT |
| 16:43:52, attempt 2 | 6.04 6.22 18.71 | 78.5% | WindowServer 41.4, Cursor Helper 18.3, kernel_task 17.5 | battery, 100% | ABORT |
| 18:06:19, attempt 3 | 7.59 12.37 16.65 | 84.9% | OrbStack Helper 10.6, WindowServer 10.4, Cursor Helper 9.5 | battery, 99% discharging | ABORT |

The build session has no after-reading taken when it ended. Its only after
check ran after the optcarrot session and the sleep, at 16:17. The
power-management log is what shows the session ran on AC power. Nothing
was running in the window but the session and the owner's desktop. No
thermal or performance warning was recorded at any check.

## Verdict

The size and compile-time cost is acceptable. It is the 4 loops that
version: +5.7 KB of C over the 64 benchmarks (+0.26%), and +11% of C in the
worst case (`bm_matmul`, +3.2 KB, +960 bytes of machine code). The stripped
binaries do not grow at all, and compile time does not move outside the
noise. A program in which no loop qualifies, optcarrot among them, compiles
to the same C and the same binary. The cost grows with the number of
versioned loops, not with program size, and optcarrot, the large program,
versions none. The run-time half of the regression question is still open
for the three changed binaries: `bm_matmul`'s kernel is already measured,
and the other two run their versioned loop once.

Follow-ups: the run-time session on AC power (command above), the
`const` warning at `src/codegen_stmt.c:6758`, and the fact that no benchmark
reaches the chunked, threaded form.

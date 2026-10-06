# Loop versioning: `make gate`, and what it costs (base `52c5ccf74` against HEAD `4ca5b952a`)

Raw data, scripts and idle readings: [`gate-and-cost/`](gate-and-cost/).
Machine: Apple M2 MacBook Air (fanless), macOS 27.0.1, Apple clang 21.0.0.
Both compilers were built with `make -j8 all` in their own detached worktrees,
`tmp/wt-base` (`52c5ccf74`) and `tmp/wt-head` (`4ca5b952a`), each with
`vendor/` symlinked to the main checkout's.

**Status: done.** The gate, which loops version, binary and C size, the
benchmarks' compile time and run time are all measured. The run-time
sessions ran on AC power from 21:53 to 21:58, after a reboot at about 19:59
([Run time](#run-time)). **HEAD runs `bm_matmul` in 0.36x base's time, and
nothing measured is slower.** Only optcarrot's compile time is still
indicative, because its re-run on AC power was not part of that pass. 61 of
the 64 benchmark binaries, and optcarrot's, are byte-identical between base
and HEAD, so only three benchmarks can differ at run time.

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
  measurably. The re-run on AC power has not been taken.

## Run time

Measured on 2026-10-06, 21:53 to 21:58 +0200, on AC power, after a reboot
at about 19:59. The binaries are the build session's (15:00 to 15:10), not
rebuilt. Their sha256, taken after the sessions, are in
[`binaries.sha256`](gate-and-cost/binaries.sha256). Base and HEAD differ
only in `bm_matmul`, `bm_spectral_norm` and `bm_huffman`. Optcarrot's
harness binary (the Makefile's recipe: `--no-line-map`,
`-DSP_INT_OVERFLOW_MODE_WRAP`) is the same file on both sides. Nothing was
built or tested during a session.

How it was measured:

- **Benchmarks:** `cost.rb run SESSION` with `ROUNDS=30`. Each benchmark
  runs 2 warm-up rounds per side, then 30 rounds that alternate which side
  goes first. A sample is the wall time of one process, spawn to exit. Each
  session (r1 and r2) took about 2 s.
- **Optcarrot:** `cost.rb fps r1 20`. 2 warm-up rounds, then 20 alternating
  rounds. Each run must print `checksum: 59662`.
- **Gating:** [`chain.rb`](gate-and-cost/chain.rb), then
  [`chain-bench.rb`](gate-and-cost/chain-bench.rb). Each waits for
  [`settle.rb`](gate-and-cost/settle.rb) to read ready: CPU at least 85%
  idle, no process at 20% CPU or more, no `mds*`/`mdworker` at 5% or more,
  and on AC power. Each session is bracketed by `cost.rb idle`. A benchmark
  session counts only when both bracket readings also pass settle's rule.
  Otherwise it is voided and retried.
- **Raw data:** [`run-r1.csv`](gate-and-cost/run-r1.csv),
  [`run-r2.csv`](gate-and-cost/run-r2.csv) and
  [`fps-r1.csv`](gate-and-cost/fps-r1.csv) hold every sample. The voided
  attempts are in [`void/`](gate-and-cost/void/), the summaries in
  [`run-summary.md`](gate-and-cost/run-summary.md), and the logs in
  [`logs/`](gate-and-cost/logs/).

"Outside the noise" means the two sides' IQRs do not overlap and the
Mann–Whitney p is below 0.01 (`analyze.rb`).

| Benchmark | Loops | Session | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | Verdict |
| --- | --: | --- | --: | --: | --: | --: | --- |
| `bm_matmul` | 2 | r1 | 8.58 (0.14) | 3.12 (0.09) | **0.364** | 2.9e-11 | faster, outside noise |
| `bm_matmul` | 2 | r2 | 8.59 (0.28) | 3.16 (0.31) | **0.368** | 2.9e-11 | faster, outside noise |
| `bm_spectral_norm` | 1 | r1 | 3.36 (0.09) | 3.36 (0.12) | 1.000 | 0.50 | within noise |
| `bm_spectral_norm` | 1 | r2 | 3.38 (0.15) | 3.37 (0.11) | 0.997 | 0.85 | within noise |
| `bm_huffman` | 1 | r1 | 7.07 (0.27) | 7.04 (0.22) | 0.996 | 0.33 | within noise |
| `bm_huffman` | 1 | r2 | 7.04 (0.09) | 7.04 (0.12) | 1.000 | 0.98 | within noise |

Optcarrot, a noise check because its binaries are the same file: the
median is 1946.4 fps on base (IQR 22.8) and 1937.8 fps on HEAD (IQR 36.1),
so head/base is 0.996 with MWU p 0.19, which is within noise. Each side has
one outlier, base 1763.0 in round 12 and HEAD 616.9 in round 10. These fps
figures are the harness's own and cannot be compared with the 244.8 fps the
gate printed under load.

- **r1 and r2 agree.** Base medians differ by 0.03 ms at most, and the
  ratios by 0.004. The five voided attempts give the same numbers to within
  0.15 ms (`bm_matmul` 0.362–0.365), with one exception: `r1-void2` ran while
  Cursor's renderer was at 66% CPU, and every median there is 0.1–1.3 ms
  higher, with IQRs of 0.4–0.8 ms. That is the gate doing its job.
- **`bm_matmul`** is 5.5 ms faster per run. If start-up is about 2.6 ms
  (Phase 03), the kernel and its init loop take about 6.0 ms on base and
  0.5 ms on HEAD, roughly 11x. That is consistent with Phase 03's 10.4x at
  `n = 500`.
- **`bm_spectral_norm` and `bm_huffman`** each run their versioned loop
  once. The guard costs nothing measurable at a resolution of about ±3%
  (IQR 0.1–0.3 ms).
- **No regression.** The 61 identical benchmark binaries were not re-timed,
  because base against head can only read noise for them. The optcarrot
  session shows that noise level.

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

### Run-time sessions (after the reboot)

The machine rebooted at about 19:59. `settle.rb` (rule above: CPU idle ≥ 85%,
no process ≥ 20%, no indexing, AC) logged every poll to
[`idle/settle.log`](gate-and-cost/idle/settle.log).

- **Settling:** from 20:02:17 (load 91.95 / 70.70 / 31.24, 48.6% idle;
  `mediaanalysisd` 154%, `mds_stores` 14%, Cursor's renderer 50%), it
  passed through `ANECompilerService` 79% and `visualintelligence` 36% at
  20:09, and read ready at 20:12:59 (load 2.88, 91.8% idle), **11 minutes
  in**.
- **Stalls:** the session launch then stalled twice, about 30 minutes and
  then about 60 minutes, on a tool permission prompt that never came up.
  That was not time spent waiting on the machine. The polls in between
  (20:43–20:47) found `duetexpertd` at 90%, then the desktop UI (WindowServer
  44%, Cursor 20–21%). From 21:47 the machine read ready again.
- **Gate waits:** inside the chains, each settle gate waited 0.5–3 minutes,
  mostly for `mediaanalysisd` and the desktop UI.
- **Total:** the time spent waiting on the machine itself was about 23
  minutes, inside the 45-minute budget.

`mediaanalysisd` came up 1–3 s after 6 of the 7 benchmark sessions, and
after the optcarrot session, at 23–96% CPU. It looks like a background task
that waits for the machine to go idle. That is why 5 attempts were voided.
In the two kept sessions, it does not show in either bracket reading.

| Session | When (+0200) | load 1/5/15 | CPU idle | top consumers (%CPU) | power, thermal | verdict |
| --- | --- | --- | --: | --- | --- | --- |
| r1 before | 21:56:23 | 2.10 2.82 2.58 | 93.2% | OrbStack Helper 6.4, kernel_task 5.5 | AC, 100% charged; no thermal or performance warning; LPM 0 | OK |
| r1 after | 21:56:26 | 2.49 2.89 2.60 | 89.7% | spotlightknowledged 11.5, OrbStack Helper 9.2 | same | OK, **kept** |
| optcarrot before | 21:53:10 | 2.78 3.35 2.67 | 88.2% | Cursor Helper (Renderer) 19.8, OrbStack Helper 6.4 | same | OK |
| optcarrot after | 21:53:18 | 2.65 3.30 2.66 | 91.5% | OrbStack Helper 8.1, kernel_task 5.9 | same | OK, **kept** |
| r2 before | 21:57:39 | 2.17 2.69 2.55 | 93.2% | OrbStack Helper 5.2, kernel_task 4.4 | same | OK |
| r2 after | 21:57:42 | 2.17 2.69 2.55 | 90.3% | kernel_task 8.0, OrbStack Helper 5.5 | same | OK, **kept** |
| r1-void1 | 21:47:16 / 21:47:19 | 1.70 1.80 1.90 | 94.5% / 79.3% | after: mediaanalysisd 96.3 | same | void |
| r1-void2 | 21:50:24 / 21:50:27 | 5.85 3.27 2.47 | 70.0% / 71.7% | before: Cursor Helper (Renderer) 66.3, WindowServer 24.5; after: mediaanalysisd 43.0 | same | void |
| r2-void1 | 21:53:53 / 21:53:56 | 2.33 3.14 2.63 | 90.4% / 91.4% | before: Cursor Helper (Renderer) 25.6; after: mediaanalysisd 25.3 | same | void |
| r1-void3 | 21:55:44 / 21:55:47 | 2.54 2.97 2.62 | 93.5% / 80.5% | after: mediaanalysisd 94.7 | same | void |
| r2-void2 | 21:57:01 / 21:57:04 | 2.17 2.76 2.57 | 91.1% / 89.5% | after: mediaanalysisd 52.4 | same | void |

The `top` process itself (5–8%) is not counted. Every reading is in
[`idle/`](gate-and-cost/idle/).

## Verdict

The size and compile-time cost is acceptable. It is the 4 loops that
version: +5.7 KB of C over the 64 benchmarks (+0.26%), and +11% of C in the
worst case (`bm_matmul`, +3.2 KB, +960 bytes of machine code). The stripped
binaries do not grow at all, and compile time does not move outside the
noise. A program in which no loop qualifies, optcarrot among them, compiles
to the same C and the same binary. The cost grows with the number of
versioned loops, not with program size, and optcarrot, the large program,
versions none.

The run-time cost is nil, and the gain is real. In two sessions that agree,
`bm_matmul` runs in 0.364x and 0.368x base's time, which is outside the
noise. `bm_spectral_norm` and `bm_huffman` read 0.996–1.000, within noise,
and so does optcarrot, whose binary is the same file (0.996). No benchmark
is slower.

Follow-ups:

- optcarrot's compile time on AC power (`cost.rb build 10
  tmp/gc/optcarrot-single.rb`, bracketed by `cost.rb idle`);
- the `const` warning at `src/codegen_stmt.c:6758`;
- the fact that no benchmark reaches the chunked, threaded form.

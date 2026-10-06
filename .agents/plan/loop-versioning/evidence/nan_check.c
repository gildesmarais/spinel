/* Which bit patterns do Float operations produce on this target, and can one
   of them be SP_FLOAT_NIL_BITS (0x7FF8000000000001, lib/sp_types.h)?
   Built with the flags spinel passes (regen.rb). Operands are volatile so
   nothing folds at compile time; every result is the hardware's. */
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define NIL_BITS 0x7FF8000000000001ULL

static uint64_t bits(double d) { uint64_t u; memcpy(&u, &d, sizeof u); return u; }
static double dbl(uint64_t u) { double d; memcpy(&d, &u, sizeof d); return d; }

static void row(const char *what, double r) {
  uint64_t b = bits(r);
  printf("%-46s 0x%016llx%s\n", what, (unsigned long long)b, b == NIL_BITS ? "  <- SP_FLOAT_NIL_BITS" : "");
}

int main(void) {
#if defined(__aarch64__)
  uint64_t fpcr;
  __asm__ volatile("mrs %0, fpcr" : "=r"(fpcr));
  printf("FPCR = 0x%llx (DN, bit 25, default-NaN mode = %llu)\n\n",
         (unsigned long long)fpcr, (unsigned long long)((fpcr >> 25) & 1));
#endif
  volatile double zero = 0.0, one = 1.0, inf = INFINITY, neg1 = -1.0;
  volatile double nil = dbl(NIL_BITS);
  volatile double qnan2 = dbl(0x7FF8000000000002ULL);       /* a quiet NaN, payload 2 */
  volatile double snan1 = dbl(0x7FF0000000000001ULL);       /* signaling NaN, payload 1 */
  volatile double negq1 = dbl(0xFFF8000000000001ULL);       /* the nil bits with the sign set */

  puts("NaNs generated from non-NaN operands (invalid operations):");
  row("0.0 / 0.0", zero / zero);
  row("inf - inf", inf - inf);
  row("0.0 * inf", zero * inf);
  row("sqrt(-1.0)", sqrt(neg1));
  row("fmod(1.0, 0.0)", fmod(one, zero));
  row("log(-1.0)", log(neg1));

  puts("\nNaN operands (propagation):");
  row("nil + 1.0 (the sentinel itself)", nil + one);
  row("1.0 * nil", one * nil);
  row("qNaN(payload 2) + 1.0", qnan2 + one);
  row("sNaN(payload 1) + 0.0", snan1 + zero);
  row("sNaN(payload 1) * 1.0", snan1 * one);
  row("-(0xFFF8000000000001)", -negq1);
  row("fabs(0xFFF8000000000001)", fabs(negq1));

  puts("\nThe same propagation through a loop clang vectorizes (fmul/fadd .2d):");
  volatile double seed[8] = { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
  double x[8], y[8];
  for (int i = 0; i < 8; i++) { x[i] = seed[i]; y[i] = seed[i]; }
  x[3] = snan1;
  x[5] = qnan2;
  for (int i = 0; i < 8; i++) y[i] = y[i] + 0.5 * x[i];
  row("y[3] = y[3] + 0.5 * sNaN(payload 1)", y[3]);
  row("y[5] = y[5] + 0.5 * qNaN(payload 2)", y[5]);
  return 0;
}

; gen/mm500.versioned.main_body.s, 40 lines ahead of the first fmul.2d and 20 after
; %bb.80:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	w14, [x12, #32]
	cbnz	w14, LBB36_41
; %bb.81:                               ;   in Loop: Header=BB36_30 Depth=2
	mul	x14, x26, x3
	add	x15, x14, #500
	cmp	x15, x13
	b.gt	LBB36_41
; %bb.82:                               ;   in Loop: Header=BB36_30 Depth=2
	fmov	x15, d16
	cmp	x15, x23
	b.eq	LBB36_41
; %bb.83:                               ;   in Loop: Header=BB36_30 Depth=2
	mul	x10, x26, x2
	add	x11, x8, x24, lsl #3
	add	x10, x9, x10
	add	x10, x10, #4000
	cmp	x11, x10
	b.hs	LBB36_86
; %bb.84:                               ;   in Loop: Header=BB36_30 Depth=2
	add	x10, x9, x14, lsl #3
	add	x11, x8, x6
	add	x11, x11, #4000
	cmp	x10, x11
	b.hs	LBB36_86
; %bb.85:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x10, #0                         ; =0x0
	b	LBB36_89
LBB36_86:                               ;   in Loop: Header=BB36_30 Depth=2
	add	x10, x8, x1
	add	x11, x9, x27
	mov	w12, #496                       ; =0x1f0
	.p2align	6
LBB36_87:                               ;   Parent Loop BB36_28 Depth=1
                                        ;     Parent Loop BB36_30 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldp	q0, q1, [x10, #-32]
	ldp	q2, q3, [x10]
	ldp	q4, q5, [x11, #-32]
	ldp	q6, q7, [x11], #64
	fmul.2d	v4, v4, v16[0]
	fmul.2d	v5, v5, v16[0]
	fmul.2d	v6, v6, v16[0]
	fmul.2d	v7, v7, v16[0]
	fadd.2d	v0, v0, v4
	fadd.2d	v1, v1, v5
	fadd.2d	v2, v2, v6
	fadd.2d	v3, v3, v7
	stp	q0, q1, [x10, #-32]
	stp	q2, q3, [x10], #64
	subs	x12, x12, #8
	b.ne	LBB36_87
; %bb.88:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	w10, #496                       ; =0x1f0
LBB36_89:                               ;   in Loop: Header=BB36_30 Depth=2
	lsl	x10, x10, #3
	add	x9, x9, x5
	add	x8, x8, x17
	.p2align	6
LBB36_90:                               ;   Parent Loop BB36_28 Depth=1

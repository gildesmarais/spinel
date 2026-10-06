__sp_main_body:                         ; @_sp_main_body
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #384
	stp	d9, d8, [sp, #272]              ; 16-byte Folded Spill
	stp	x28, x27, [sp, #288]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #304]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #320]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #336]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #352]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #368]            ; 16-byte Folded Spill
	add	x29, sp, #368
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
Lloh596:
	adrp	x9, _sp_gc_nroots@GOTPAGE
Lloh597:
	ldr	x9, [x9, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w10, [x9]
Lloh598:
	adrp	x8, l___const._sp_main_body._gcf@PAGE
Lloh599:
	add	x8, x8, l___const._sp_main_body._gcf@PAGEOFF
	ldp	q0, q1, [x8]
	stp	q0, q1, [sp, #160]
	add	x8, sp, #160
	orr	x0, x8, #0x3
	cmp	w10, #16, lsl #12               ; =65536
	str	w10, [sp, #116]                 ; 4-byte Folded Spill
	b.ge	LBB36_2
; %bb.1:
	add	w8, w10, #1
	str	w8, [x9]
Lloh600:
	adrp	x8, _sp_gc_roots@GOTPAGE
Lloh601:
	ldr	x8, [x8, _sp_gc_roots@GOTPAGEOFF]
	str	x0, [x8, w10, sxtw #3]
	b	LBB36_3
LBB36_2:
	bl	_sp_gc_root_push_slow
LBB36_3:
Lloh602:
	adrp	x8, _sp_alloc_report_on@GOTPAGE
Lloh603:
	ldr	x8, [x8, _sp_alloc_report_on@GOTPAGEOFF]
Lloh604:
	ldr	w8, [x8]
	cbz	w8, LBB36_5
; %bb.4:
Lloh605:
	adrp	x0, _sp_PolyArray_scan@PAGE
Lloh606:
	add	x0, x0, _sp_PolyArray_scan@PAGEOFF
Lloh607:
	adrp	x1, l_.str.201@PAGE
Lloh608:
	add	x1, x1, l_.str.201@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh609:
	adrp	x0, _sp_StrArray_scan@PAGE
Lloh610:
	add	x0, x0, _sp_StrArray_scan@PAGEOFF
Lloh611:
	adrp	x1, l_.str.202@PAGE
Lloh612:
	add	x1, x1, l_.str.202@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh613:
	adrp	x0, _sp_SymPolyHash_scan@PAGE
Lloh614:
	add	x0, x0, _sp_SymPolyHash_scan@PAGEOFF
Lloh615:
	adrp	x1, l_.str.203@PAGE
Lloh616:
	add	x1, x1, l_.str.203@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh617:
	adrp	x0, _sp_StrPolyHash_scan@PAGE
Lloh618:
	add	x0, x0, _sp_StrPolyHash_scan@PAGEOFF
Lloh619:
	adrp	x1, l_.str.204@PAGE
Lloh620:
	add	x1, x1, l_.str.204@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh621:
	adrp	x0, _sp_PolyPolyHash_scan@PAGE
Lloh622:
	add	x0, x0, _sp_PolyPolyHash_scan@PAGEOFF
Lloh623:
	adrp	x1, l_.str.205@PAGE
Lloh624:
	add	x1, x1, l_.str.205@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh625:
	adrp	x0, _sp_Enumerator_scan@GOTPAGE
Lloh626:
	ldr	x0, [x0, _sp_Enumerator_scan@GOTPAGEOFF]
Lloh627:
	adrp	x1, l_.str.206@PAGE
Lloh628:
	add	x1, x1, l_.str.206@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh629:
	adrp	x0, _sp_OpenStruct_scan@PAGE
Lloh630:
	add	x0, x0, _sp_OpenStruct_scan@PAGEOFF
Lloh631:
	adrp	x1, l_.str.207@PAGE
Lloh632:
	add	x1, x1, l_.str.207@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh633:
	adrp	x0, _sp_Dir_scan@GOTPAGE
Lloh634:
	ldr	x0, [x0, _sp_Dir_scan@GOTPAGEOFF]
Lloh635:
	adrp	x1, l_.str.208@PAGE
Lloh636:
	add	x1, x1, l_.str.208@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh637:
	adrp	x0, _sp_Proc_scan@GOTPAGE
Lloh638:
	ldr	x0, [x0, _sp_Proc_scan@GOTPAGEOFF]
Lloh639:
	adrp	x1, l_.str.209@PAGE
Lloh640:
	add	x1, x1, l_.str.209@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh641:
	adrp	x0, _sp_exc_gc_scan@GOTPAGE
Lloh642:
	ldr	x0, [x0, _sp_exc_gc_scan@GOTPAGEOFF]
Lloh643:
	adrp	x1, l_.str.210@PAGE
Lloh644:
	add	x1, x1, l_.str.210@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh645:
	adrp	x0, _sp_PtrArray_gc_scan@PAGE
Lloh646:
	add	x0, x0, _sp_PtrArray_gc_scan@PAGEOFF
Lloh647:
	adrp	x1, l_.str.211@PAGE
Lloh648:
	add	x1, x1, l_.str.211@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh649:
	adrp	x0, _sp_StrIntHash_scan@GOTPAGE
Lloh650:
	ldr	x0, [x0, _sp_StrIntHash_scan@GOTPAGEOFF]
Lloh651:
	adrp	x1, l_.str.212@PAGE
Lloh652:
	add	x1, x1, l_.str.212@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh653:
	adrp	x0, _sp_StrStrHash_scan@GOTPAGE
Lloh654:
	ldr	x0, [x0, _sp_StrStrHash_scan@GOTPAGEOFF]
Lloh655:
	adrp	x1, l_.str.213@PAGE
Lloh656:
	add	x1, x1, l_.str.213@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh657:
	adrp	x0, _sp_IntStrHash_scan@GOTPAGE
Lloh658:
	ldr	x0, [x0, _sp_IntStrHash_scan@GOTPAGEOFF]
Lloh659:
	adrp	x1, l_.str.214@PAGE
Lloh660:
	add	x1, x1, l_.str.214@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh661:
	adrp	x0, _sp_curry_scan@GOTPAGE
Lloh662:
	ldr	x0, [x0, _sp_curry_scan@GOTPAGEOFF]
Lloh663:
	adrp	x1, l_.str.215@PAGE
Lloh664:
	add	x1, x1, l_.str.215@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh665:
	adrp	x0, _sp_BoundMethod_scan@GOTPAGE
Lloh666:
	ldr	x0, [x0, _sp_BoundMethod_scan@GOTPAGEOFF]
Lloh667:
	adrp	x1, l_.str.216@PAGE
Lloh668:
	add	x1, x1, l_.str.216@PAGEOFF
	bl	_sp_alloc_report_tag
LBB36_5:
Lloh669:
	adrp	x8, _sp_sym_name_fn@GOTPAGE
Lloh670:
	ldr	x8, [x8, _sp_sym_name_fn@GOTPAGEOFF]
Lloh671:
	adrp	x9, _sp_sym_to_s@PAGE
Lloh672:
	add	x9, x9, _sp_sym_to_s@PAGEOFF
Lloh673:
	str	x9, [x8]
Lloh674:
	adrp	x8, _sp_stack_overflow_raise_fn@GOTPAGE
Lloh675:
	ldr	x8, [x8, _sp_stack_overflow_raise_fn@GOTPAGEOFF]
Lloh676:
	adrp	x9, _sp_raise_stack_overflow@PAGE
Lloh677:
	add	x9, x9, _sp_raise_stack_overflow@PAGEOFF
Lloh678:
	str	x9, [x8]
	bl	_sp_stack_guard_init
Lloh679:
	adrp	x8, _sp_user_exc_parent@PAGE
Lloh680:
	add	x8, x8, _sp_user_exc_parent@PAGEOFF
Lloh681:
	adrp	x9, _sp_user_exc_parent_fn@PAGE
	str	x8, [x9, _sp_user_exc_parent_fn@PAGEOFF]
Lloh682:
	adrp	x8, _sp_user_exc_modules_fn@GOTPAGE
Lloh683:
	ldr	x8, [x8, _sp_user_exc_modules_fn@GOTPAGEOFF]
Lloh684:
	adrp	x9, _sp_user_exc_modules@PAGE
Lloh685:
	add	x9, x9, _sp_user_exc_modules@PAGEOFF
Lloh686:
	str	x9, [x8]
Lloh687:
	adrp	x8, _sp_poly_is_a@PAGE
Lloh688:
	add	x8, x8, _sp_poly_is_a@PAGEOFF
Lloh689:
	adrp	x9, _sp_poly_is_a_hook@PAGE
	str	x8, [x9, _sp_poly_is_a_hook@PAGEOFF]
Lloh690:
	adrp	x8, _sp_class_le_id_fn@GOTPAGE
Lloh691:
	ldr	x8, [x8, _sp_class_le_id_fn@GOTPAGEOFF]
Lloh692:
	adrp	x9, _sp_class_le_ids@PAGE
Lloh693:
	add	x9, x9, _sp_class_le_ids@PAGEOFF
Lloh694:
	str	x9, [x8]
Lloh695:
	adrp	x8, _sp_class_cmp_fn@GOTPAGE
Lloh696:
	ldr	x8, [x8, _sp_class_cmp_fn@GOTPAGEOFF]
Lloh697:
	adrp	x9, _sp_class_cmp_rv@PAGE
Lloh698:
	add	x9, x9, _sp_class_cmp_rv@PAGEOFF
Lloh699:
	adrp	x10, _sp_class_kind_of_name_fn@GOTPAGE
Lloh700:
	ldr	x10, [x10, _sp_class_kind_of_name_fn@GOTPAGEOFF]
Lloh701:
	str	x9, [x8]
Lloh702:
	adrp	x8, _sp_class_kind_of_name@PAGE
Lloh703:
	add	x8, x8, _sp_class_kind_of_name@PAGEOFF
Lloh704:
	str	x8, [x10]
Lloh705:
	adrp	x8, _sp_class_is_module_fn@GOTPAGE
Lloh706:
	ldr	x8, [x8, _sp_class_is_module_fn@GOTPAGEOFF]
Lloh707:
	adrp	x9, _sp_class_is_module_val@PAGE
Lloh708:
	add	x9, x9, _sp_class_is_module_val@PAGEOFF
Lloh709:
	adrp	x10, _sp_gc_mark_globals_hook@GOTPAGE
Lloh710:
	ldr	x10, [x10, _sp_gc_mark_globals_hook@GOTPAGEOFF]
Lloh711:
	adrp	x11, _sp_mark_user_globals@PAGE
Lloh712:
	add	x11, x11, _sp_mark_user_globals@PAGEOFF
Lloh713:
	str	x9, [x8]
Lloh714:
	str	x11, [x10]
Lloh715:
	adrp	x8, _sp_json_sym_intern_fn@GOTPAGE
Lloh716:
	ldr	x8, [x8, _sp_json_sym_intern_fn@GOTPAGEOFF]
Lloh717:
	adrp	x9, _sp_sym_intern@PAGE
Lloh718:
	add	x9, x9, _sp_sym_intern@PAGEOFF
Lloh719:
	str	x9, [x8]
Lloh720:
	adrp	x8, __sp_main_argc@PAGE
Lloh721:
	ldr	w21, [x8, __sp_main_argc@PAGEOFF]
	subs	w19, w21, #1
Lloh722:
	adrp	x22, _sp_argv@GOTPAGE
Lloh723:
	ldr	x22, [x22, _sp_argv@GOTPAGEOFF]
	sxtw	x8, w19
	str	x8, [x22, #8]
	csinc	w8, w19, wzr, gt
	ubfiz	x0, x8, #3, #32
Lloh724:
	adrp	x8, __sp_main_argv@PAGE
Lloh725:
	ldr	x20, [x8, __sp_main_argv@PAGEOFF]
	bl	_malloc
	str	x0, [x22]
	cmp	w21, #2
	b.lt	LBB36_22
; %bb.6:
	mov	x26, #0                         ; =0x0
	ubfiz	x27, x19, #3, #32
	add	x28, x20, #8
Lloh726:
	adrp	x19, _sp_str_stress_checked@GOTPAGE
Lloh727:
	ldr	x19, [x19, _sp_str_stress_checked@GOTPAGEOFF]
Lloh728:
	adrp	x25, _sp_str_heap_bytes@GOTPAGE
Lloh729:
	ldr	x25, [x25, _sp_str_heap_bytes@GOTPAGEOFF]
Lloh730:
	adrp	x24, _sp_str_heap@GOTPAGE
Lloh731:
	ldr	x24, [x24, _sp_str_heap@GOTPAGEOFF]
	b	LBB36_9
	.p2align	6
LBB36_7:                                ;   in Loop: Header=BB36_9 Depth=1
	mov	x22, #0                         ; =0x0
LBB36_8:                                ;   in Loop: Header=BB36_9 Depth=1
	str	x22, [x0, x26]
	add	x26, x26, #8
	cmp	x27, x26
	b.eq	LBB36_22
LBB36_9:                                ; =>This Inner Loop Header: Depth=1
	ldr	x20, [x28, x26]
	cbz	x20, LBB36_7
; %bb.10:                               ;   in Loop: Header=BB36_9 Depth=1
	mov	x0, x20
	bl	_strlen
	mov	x21, x0
	ldr	w8, [x19]
	cbz	w8, LBB36_18
LBB36_11:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x25]
Lloh732:
	adrp	x9, _sp_str_threshold@GOTPAGE
Lloh733:
	ldr	x9, [x9, _sp_str_threshold@GOTPAGEOFF]
Lloh734:
	ldr	x9, [x9]
	cmp	x8, x9
	b.ls	LBB36_13
; %bb.12:                               ;   in Loop: Header=BB36_9 Depth=1
	bl	_sp_str_collect_retune
LBB36_13:                               ;   in Loop: Header=BB36_9 Depth=1
	add	x23, x21, #26
	mov	x0, x23
	bl	_sp_slab_alloc_str
	mov	x22, x0
	stp	w23, w21, [x0, #8]
	str	xzr, [x0, #16]
Lloh735:
	adrp	x8, _sp_slab_base@GOTPAGE
Lloh736:
	ldr	x8, [x8, _sp_slab_base@GOTPAGEOFF]
Lloh737:
	ldr	x8, [x8]
Lloh738:
	adrp	x9, _sp_slab_cap@GOTPAGE
Lloh739:
	ldr	x9, [x9, _sp_slab_cap@GOTPAGEOFF]
Lloh740:
	ldr	x9, [x9]
	sub	x8, x0, x8
	cmp	x8, x9
	b.lo	LBB36_15
; %bb.14:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x24]
	str	x8, [x22]
	str	x22, [x24]
LBB36_15:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x25]
	add	x8, x8, x23
	str	x8, [x25]
	mov	x8, x22
	mov	w9, #254                        ; =0xfe
	strb	w9, [x8, #24]!
	add	x8, x8, x21
	strb	wzr, [x8, #1]
Lloh741:
	adrp	x8, _sp_alloc_report_on@GOTPAGE
Lloh742:
	ldr	x8, [x8, _sp_alloc_report_on@GOTPAGEOFF]
Lloh743:
	ldr	w8, [x8]
	cbz	w8, LBB36_17
; %bb.16:                               ;   in Loop: Header=BB36_9 Depth=1
	mov	x0, x21
	bl	_sp_alloc_report_str
LBB36_17:                               ;   in Loop: Header=BB36_9 Depth=1
	add	x22, x22, #25
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	bl	_memcpy
Lloh744:
	adrp	x8, _sp_argv@GOTPAGE
Lloh745:
	ldr	x8, [x8, _sp_argv@GOTPAGEOFF]
Lloh746:
	ldr	x0, [x8]
	b	LBB36_8
	.p2align	6
LBB36_18:                               ;   in Loop: Header=BB36_9 Depth=1
	mov	w8, #1                          ; =0x1
	str	w8, [x19]
Lloh747:
	adrp	x0, l_.str.48@PAGE
Lloh748:
	add	x0, x0, l_.str.48@PAGEOFF
	bl	_getenv
	cbz	x0, LBB36_11
; %bb.19:                               ;   in Loop: Header=BB36_9 Depth=1
	ldrb	w8, [x0]
	cbz	w8, LBB36_11
; %bb.20:                               ;   in Loop: Header=BB36_9 Depth=1
	cmp	w8, #48
	b.eq	LBB36_11
; %bb.21:                               ;   in Loop: Header=BB36_9 Depth=1
Lloh749:
	adrp	x8, _sp_str_threshold@GOTPAGE
Lloh750:
	ldr	x8, [x8, _sp_str_threshold@GOTPAGEOFF]
	mov	w9, #2048                       ; =0x800
Lloh751:
	str	x9, [x8]
Lloh752:
	adrp	x8, _sp_str_threshold_init@GOTPAGE
Lloh753:
	ldr	x8, [x8, _sp_str_threshold_init@GOTPAGEOFF]
Lloh754:
	str	x9, [x8]
	mov	w8, #1                          ; =0x1
Lloh755:
	adrp	x9, _sp_gc_stress_pin@GOTPAGE
Lloh756:
	ldr	x9, [x9, _sp_gc_stress_pin@GOTPAGEOFF]
Lloh757:
	str	w8, [x9]
	b	LBB36_11
LBB36_22:
	stp	xzr, xzr, [sp, #144]
	add	x8, sp, #152
	add	x9, sp, #144
	stp	x8, x9, [sp, #168]
	str	xzr, [sp, #136]
	add	x8, sp, #136
	str	x8, [sp, #184]
Lloh758:
	adrp	x0, l_.str.18@PAGE
Lloh759:
	add	x0, x0, l_.str.18@PAGEOFF
	bl	_getenv
Lloh760:
	adrp	x8, l_.str.19@PAGE
Lloh761:
	add	x8, x8, l_.str.19@PAGEOFF
	cmp	x0, #0
	csel	x0, x8, x0, eq
	mov	x1, #0                          ; =0x0
	mov	w2, #10                         ; =0xa
	bl	_strtoll
	mov	x19, x0
	bl	_sp_matgen
	str	x0, [sp, #152]
	mov	x0, x19
	bl	_sp_matgen
	str	x0, [sp, #144]
	ldr	x8, [sp, #152]
	stp	x0, x8, [x29, #-120]
Lloh762:
	adrp	x23, _sp_gc_nroots@GOTPAGE
Lloh763:
	ldr	x23, [x23, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w22, [x23]
	movi.2d	v0, #0000000000000000
	stur	xzr, [x29, #-128]
	stp	q0, q0, [x29, #-160]
	mov	w8, #4                          ; =0x4
	stur	w8, [x29, #-156]
	sub	x8, x29, #160
	orr	x0, x8, #0x3
	cmp	w22, #16, lsl #12               ; =65536
	b.ge	LBB36_24
; %bb.23:
	add	w8, w22, #1
	str	w8, [x23]
Lloh764:
	adrp	x8, _sp_gc_roots@GOTPAGE
Lloh765:
	ldr	x8, [x8, _sp_gc_roots@GOTPAGEOFF]
	str	x0, [x8, w22, sxtw #3]
	b	LBB36_25
LBB36_24:
	bl	_sp_gc_root_push_slow
LBB36_25:
	sub	x8, x29, #112
	sub	x9, x29, #120
	stp	x8, x9, [x29, #-152]
	stur	xzr, [x29, #-168]
	sub	x8, x29, #168
	stur	x8, [x29, #-136]
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x19, x8
	b.eq	LBB36_180
; %bb.26:
	mul	x24, x19, x19
	smulh	x8, x19, x19
	cmp	x8, x24, asr #63
	b.ne	LBB36_189
; %bb.27:
	tbnz	x24, #63, LBB36_190
; %bb.28:
Lloh766:
	adrp	x1, _sp_FloatArray_fin@PAGE
Lloh767:
	add	x1, x1, _sp_FloatArray_fin@PAGEOFF
	mov	w0, #40                         ; =0x28
	mov	x2, #0                          ; =0x0
	bl	_sp_gc_alloc
	mov	x21, x0
	lsr	x8, x24, #61
	cbz	x8, LBB36_30
; %bb.29:
	bl	_sp_oom_die
LBB36_30:
	mov	w8, #16                         ; =0x10
	cmp	x24, #16
	csel	x8, x24, x8, hi
	str	x8, [x21, #16]
	lsl	x0, x8, #3
	bl	_sp_slab_alloc_raw
	str	x0, [x21]
	cbnz	x0, LBB36_32
; %bb.31:
	bl	_sp_oom_die
LBB36_32:
	cbz	x24, LBB36_34
; %bb.33:
	ldr	x0, [x21]
	lsl	x1, x24, #3
	bl	_bzero
LBB36_34:
	mov	x26, #1                         ; =0x1
	movk	x26, #32760, lsl #48
	str	x24, [x21, #8]
	ldr	x8, [x21, #16]
	lsl	x8, x8, #3
	ldur	x9, [x21, #-24]
	add	x9, x9, x8
	stur	x9, [x21, #-24]
Lloh768:
	adrp	x9, _sp_gc_bytes@GOTPAGE
Lloh769:
	ldr	x9, [x9, _sp_gc_bytes@GOTPAGEOFF]
	ldr	x10, [x9]
	add	x8, x10, x8
	str	x8, [x9]
	stp	x21, x21, [x29, #-176]
	sub	x8, x29, #176
	stur	x8, [x29, #-128]
	cmp	x19, #1
	b.lt	LBB36_126
; %bb.35:
	mov	x17, #0                         ; =0x0
	mov	x1, #0                          ; =0x0
	lsl	x2, x19, #3
	and	x3, x19, #0x7ffffffffffffff8
	mov	w4, #32                         ; =0x20
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	mov	w5, #1                          ; =0x1
	mov	x20, x21
	str	x24, [sp, #96]                  ; 8-byte Folded Spill
	str	w22, [sp, #92]                  ; 4-byte Folded Spill
LBB36_36:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB36_40 Depth 2
                                        ;       Child Loop BB36_122 Depth 3
                                        ;       Child Loop BB36_120 Depth 3
                                        ;       Child Loop BB36_61 Depth 3
                                        ;         Child Loop BB36_101 Depth 4
	mul	x27, x1, x19
	smulh	x8, x1, x19
	cmp	x8, x27, asr #63
	cset	w8, ne
	cmp	x27, #0
	cset	w9, lt
	adds	x6, x27, x19
	csinc	w7, w9, wzr, vc
	tbnz	w8, #0, LBB36_191
; %bb.37:                               ;   in Loop: Header=BB36_36 Depth=1
	mov	x30, #0                         ; =0x0
	mov	x22, #0                         ; =0x0
	mul	x8, x2, x1
	str	x8, [sp, #104]                  ; 8-byte Folded Spill
	mov	w23, #32                        ; =0x20
	b	LBB36_40
LBB36_38:                               ;   in Loop: Header=BB36_40 Depth=2
	mov	x14, x21
	.p2align	6
LBB36_39:                               ;   in Loop: Header=BB36_40 Depth=2
	ldp	x23, x22, [sp, #120]            ; 16-byte Folded Reload
	add	x22, x22, #1
	add	x23, x23, x2
	add	x30, x30, x2
	cmp	x22, x19
	b.eq	LBB36_124
LBB36_40:                               ;   Parent Loop BB36_36 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB36_122 Depth 3
                                        ;       Child Loop BB36_120 Depth 3
                                        ;       Child Loop BB36_61 Depth 3
                                        ;         Child Loop BB36_101 Depth 4
	cmp	x27, x0
	b.eq	LBB36_179
; %bb.41:                               ;   in Loop: Header=BB36_40 Depth=2
	adds	x8, x27, x22
	b.vs	LBB36_188
; %bb.42:                               ;   in Loop: Header=BB36_40 Depth=2
	ldur	x9, [x29, #-112]
	cbz	x9, LBB36_49
; %bb.43:                               ;   in Loop: Header=BB36_40 Depth=2
	ldr	x10, [x9, #8]
	tbz	x8, #63, LBB36_45
; %bb.44:                               ;   in Loop: Header=BB36_40 Depth=2
	adds	x8, x10, x8
	b.mi	LBB36_49
LBB36_45:                               ;   in Loop: Header=BB36_40 Depth=2
	cmp	x8, x10
	b.ge	LBB36_49
; %bb.46:                               ;   in Loop: Header=BB36_40 Depth=2
	ldr	x9, [x9]
	ldr	d16, [x9, x8, lsl #3]
	cbnz	x21, LBB36_50
LBB36_47:                               ;   in Loop: Header=BB36_40 Depth=2
	mov	x10, #0                         ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
	ldur	x12, [x29, #-120]
	cbnz	x12, LBB36_51
LBB36_48:                               ;   in Loop: Header=BB36_40 Depth=2
	mov	x9, #0                          ; =0x0
	mov	x13, #0                         ; =0x0
	b	LBB36_52
	.p2align	6
LBB36_49:                               ;   in Loop: Header=BB36_40 Depth=2
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d16, x8
	cbz	x21, LBB36_47
LBB36_50:                               ;   in Loop: Header=BB36_40 Depth=2
	ldp	x8, x10, [x21]
	ldr	x9, [x21, #24]
	cmp	x9, #0
	cset	w11, eq
	ldur	x12, [x29, #-120]
	cbz	x12, LBB36_48
LBB36_51:                               ;   in Loop: Header=BB36_40 Depth=2
	ldp	x9, x13, [x12]
LBB36_52:                               ;   in Loop: Header=BB36_40 Depth=2
	smulh	x14, x22, x19
	stp	x23, x22, [sp, #120]            ; 16-byte Folded Spill
	cbz	x21, LBB36_60
; %bb.53:                               ;   in Loop: Header=BB36_40 Depth=2
	cbz	x8, LBB36_60
; %bb.54:                               ;   in Loop: Header=BB36_40 Depth=2
	cbz	w11, LBB36_60
; %bb.55:                               ;   in Loop: Header=BB36_40 Depth=2
	ldr	w15, [x21, #32]
	cmp	w15, #0
	csinc	w15, w7, wzr, eq
	tbnz	w15, #0, LBB36_60
; %bb.56:                               ;   in Loop: Header=BB36_40 Depth=2
	cmp	x6, x10
	b.gt	LBB36_60
; %bb.57:                               ;   in Loop: Header=BB36_40 Depth=2
	cbz	x12, LBB36_60
; %bb.58:                               ;   in Loop: Header=BB36_40 Depth=2
	cbz	x9, LBB36_60
; %bb.59:                               ;   in Loop: Header=BB36_40 Depth=2
	ldr	w15, [x12, #32]
	cbz	w15, LBB36_110
	.p2align	6
LBB36_60:                               ;   in Loop: Header=BB36_40 Depth=2
	mov	x24, #0                         ; =0x0
	mul	x25, x22, x19
	cmp	x14, x25, asr #63
	cset	w23, ne
	fmov	x28, d16
	mov	x14, x21
	.p2align	6
LBB36_61:                               ;   Parent Loop BB36_36 Depth=1
                                        ;     Parent Loop BB36_40 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB36_101 Depth 4
	adds	x22, x27, x24
	b.vs	LBB36_181
; %bb.62:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x22, x10
	b.hs	LBB36_64
; %bb.63:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	d0, [x8, x22, lsl #3]
	b	LBB36_72
	.p2align	6
LBB36_64:                               ;   in Loop: Header=BB36_61 Depth=3
	cbz	x20, LBB36_69
; %bb.65:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x15, [x20, #8]
	mov	x14, x22
	tbz	x22, #63, LBB36_67
; %bb.66:                               ;   in Loop: Header=BB36_61 Depth=3
	adds	x14, x15, x22
	b.mi	LBB36_70
LBB36_67:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x14, x15
	b.ge	LBB36_70
; %bb.68:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x15, [x20]
	ldr	d0, [x15, x14, lsl #3]
	b	LBB36_71
LBB36_69:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x21, #0                         ; =0x0
	mov	x14, #0                         ; =0x0
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d0, x15
	b	LBB36_72
LBB36_70:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x14, #1                         ; =0x1
	movk	x14, #32760, lsl #48
	fmov	d0, x14
LBB36_71:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x21, x20
	mov	x14, x20
LBB36_72:                               ;   in Loop: Header=BB36_61 Depth=3
	cbnz	w23, LBB36_182
; %bb.73:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x25, x0
	b.eq	LBB36_159
; %bb.74:                               ;   in Loop: Header=BB36_61 Depth=3
	adds	x15, x25, x24
	b.vs	LBB36_183
; %bb.75:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x15, x13
	b.hs	LBB36_77
; %bb.76:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	d1, [x9, x15, lsl #3]
	b	LBB36_83
	.p2align	6
LBB36_77:                               ;   in Loop: Header=BB36_61 Depth=3
	cbz	x12, LBB36_82
; %bb.78:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x16, [x12, #8]
	tbz	x15, #63, LBB36_80
; %bb.79:                               ;   in Loop: Header=BB36_61 Depth=3
	adds	x15, x16, x15
	b.mi	LBB36_82
LBB36_80:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x15, x16
	b.ge	LBB36_82
; %bb.81:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x16, [x12]
	ldr	d1, [x16, x15, lsl #3]
	b	LBB36_83
	.p2align	6
LBB36_82:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d1, x15
LBB36_83:                               ;   in Loop: Header=BB36_61 Depth=3
	cmp	x28, x26
	b.eq	LBB36_130
; %bb.84:                               ;   in Loop: Header=BB36_61 Depth=3
	fmov	x15, d1
	cmp	x15, x26
	b.eq	LBB36_130
; %bb.85:                               ;   in Loop: Header=BB36_61 Depth=3
	fmov	x15, d0
	cmp	x15, x26
	b.eq	LBB36_131
; %bb.86:                               ;   in Loop: Header=BB36_61 Depth=3
	fmul	d1, d16, d1
	fmov	x16, d1
	cmp	x16, x26
	b.eq	LBB36_131
; %bb.87:                               ;   in Loop: Header=BB36_61 Depth=3
	fadd	d8, d0, d1
	cmp	x22, x10
	b.hs	LBB36_91
; %bb.88:                               ;   in Loop: Header=BB36_61 Depth=3
	cbz	w11, LBB36_91
; %bb.89:                               ;   in Loop: Header=BB36_61 Depth=3
	str	d8, [x8, x22, lsl #3]
	mov	w11, #1                         ; =0x1
LBB36_90:                               ;   in Loop: Header=BB36_61 Depth=3
	add	x24, x24, #1
	cmp	x24, x19
	b.ne	LBB36_61
	b	LBB36_39
LBB36_91:                               ;   in Loop: Header=BB36_61 Depth=3
	cbz	x20, LBB36_95
; %bb.92:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x8, [x20, #24]
	cbnz	x8, LBB36_193
; %bb.93:                               ;   in Loop: Header=BB36_61 Depth=3
	stp	x2, x1, [sp, #72]               ; 16-byte Folded Spill
	stp	x4, x3, [sp, #56]               ; 16-byte Folded Spill
	str	x6, [sp, #48]                   ; 8-byte Folded Spill
	str	w7, [sp, #44]                   ; 4-byte Folded Spill
	str	x30, [sp, #32]                  ; 8-byte Folded Spill
	str	q16, [sp, #16]                  ; 16-byte Folded Spill
	tbnz	x22, #63, LBB36_97
; %bb.94:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x21, x17
	b	LBB36_99
LBB36_95:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x10, #0                         ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
	ldur	x12, [x29, #-120]
	cbnz	x12, LBB36_107
LBB36_96:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x13, #0                         ; =0x0
	mov	x9, #0                          ; =0x0
	b	LBB36_108
LBB36_97:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x0, [x20, #8]
	adds	x8, x0, x22
	b.mi	LBB36_194
; %bb.98:                               ;   in Loop: Header=BB36_61 Depth=3
	mov	x21, x17
	mov	x22, x8
LBB36_99:                               ;   in Loop: Header=BB36_61 Depth=3
	ldr	x8, [x20, #16]
	cmp	x22, x8
	b.lt	LBB36_102
; %bb.100:                              ;   in Loop: Header=BB36_61 Depth=3
	ldr	x0, [x20]
	.p2align	6
LBB36_101:                              ;   Parent Loop BB36_36 Depth=1
                                        ;     Parent Loop BB36_40 Depth=2
                                        ;       Parent Loop BB36_61 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	orr	x8, x5, x8, lsl #1
	str	x8, [x20, #16]
	lsl	x1, x8, #3
	bl	_sp_pl_realloc
	mov	w5, #1                          ; =0x1
	str	x0, [x20]
	ldr	x8, [x20, #16]
	cmp	x22, x8
	b.ge	LBB36_101
LBB36_102:                              ;   in Loop: Header=BB36_61 Depth=3
	ldr	x8, [x20, #8]
	cmp	x22, x8
	b.ge	LBB36_109
LBB36_103:                              ;   in Loop: Header=BB36_61 Depth=3
	ldr	x8, [x20]
	str	d8, [x8, x22, lsl #3]
	ldur	x20, [x29, #-168]
	cbz	x20, LBB36_105
; %bb.104:                              ;   in Loop: Header=BB36_61 Depth=3
	ldp	x8, x10, [x20]
	ldr	x9, [x20, #24]
	cmp	x9, #0
	cset	w11, eq
	b	LBB36_106
LBB36_105:                              ;   in Loop: Header=BB36_61 Depth=3
	mov	x10, #0                         ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w11, #0                         ; =0x0
LBB36_106:                              ;   in Loop: Header=BB36_61 Depth=3
	mov	x17, x21
	ldp	x2, x1, [sp, #72]               ; 16-byte Folded Reload
	ldp	x4, x3, [sp, #56]               ; 16-byte Folded Reload
	mov	x0, #-9223372036854775808       ; =0x8000000000000000
	ldr	x6, [sp, #48]                   ; 8-byte Folded Reload
	ldr	w7, [sp, #44]                   ; 4-byte Folded Reload
	ldr	x30, [sp, #32]                  ; 8-byte Folded Reload
	ldr	q16, [sp, #16]                  ; 16-byte Folded Reload
	ldur	x12, [x29, #-120]
	cbz	x12, LBB36_96
LBB36_107:                              ;   in Loop: Header=BB36_61 Depth=3
	ldp	x9, x13, [x12]
LBB36_108:                              ;   in Loop: Header=BB36_61 Depth=3
	mov	x21, x20
	mov	x14, x20
	b	LBB36_90
LBB36_109:                              ;   in Loop: Header=BB36_61 Depth=3
	mov	x0, x20
	mov	x1, x22
	bl	_sp_FloatArray_fill_to
	mov	w5, #1                          ; =0x1
	b	LBB36_103
LBB36_110:                              ;   in Loop: Header=BB36_40 Depth=2
	mul	x15, x22, x19
	cmp	x14, x15, asr #63
	b.ne	LBB36_60
; %bb.111:                              ;   in Loop: Header=BB36_40 Depth=2
	tbnz	x15, #63, LBB36_60
; %bb.112:                              ;   in Loop: Header=BB36_40 Depth=2
	adds	x16, x15, x19
	b.vs	LBB36_60
; %bb.113:                              ;   in Loop: Header=BB36_40 Depth=2
	cmp	x16, x13
	b.gt	LBB36_60
; %bb.114:                              ;   in Loop: Header=BB36_40 Depth=2
	fmov	x16, d16
	cmp	x16, x26
	b.eq	LBB36_60
; %bb.115:                              ;   in Loop: Header=BB36_40 Depth=2
	cmp	x19, #8
	b.lo	LBB36_118
; %bb.116:                              ;   in Loop: Header=BB36_40 Depth=2
	mul	x10, x2, x22
	add	x11, x8, x27, lsl #3
	add	x12, x9, x2
	add	x10, x12, x10
	cmp	x11, x10
	b.hs	LBB36_121
; %bb.117:                              ;   in Loop: Header=BB36_40 Depth=2
	add	x10, x9, x15, lsl #3
	add	x11, x8, x2
	ldr	x12, [sp, #104]                 ; 8-byte Folded Reload
	add	x11, x11, x12
	cmp	x10, x11
	b.hs	LBB36_121
LBB36_118:                              ;   in Loop: Header=BB36_40 Depth=2
	mov	x11, #0                         ; =0x0
LBB36_119:                              ;   in Loop: Header=BB36_40 Depth=2
	sub	x10, x19, x11
	lsl	x11, x11, #3
	add	x9, x9, x30
	add	x9, x9, x11
	add	x8, x8, x17
	add	x8, x8, x11
	.p2align	6
LBB36_120:                              ;   Parent Loop BB36_36 Depth=1
                                        ;     Parent Loop BB36_40 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	d0, [x9], #8
	ldr	d1, [x8]
	fmul	d0, d16, d0
	fadd	d0, d1, d0
	str	d0, [x8], #8
	subs	x10, x10, #1
	b.ne	LBB36_120
	b	LBB36_38
LBB36_121:                              ;   in Loop: Header=BB36_40 Depth=2
	add	x10, x8, x4
	add	x11, x9, x23
	mov	x12, x3
	.p2align	6
LBB36_122:                              ;   Parent Loop BB36_36 Depth=1
                                        ;     Parent Loop BB36_40 Depth=2
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
	b.ne	LBB36_122
; %bb.123:                              ;   in Loop: Header=BB36_40 Depth=2
	mov	x11, x3
	cmp	x19, x3
	b.eq	LBB36_38
	b	LBB36_119
	.p2align	6
LBB36_124:                              ;   in Loop: Header=BB36_36 Depth=1
	cmn	x1, #1
	b.vs	LBB36_192
; %bb.125:                              ;   in Loop: Header=BB36_36 Depth=1
	add	x1, x1, #1
	add	x4, x4, x2
	add	x17, x17, x2
	cmp	x1, x19
Lloh770:
	adrp	x23, _sp_gc_nroots@GOTPAGE
Lloh771:
	ldr	x23, [x23, _sp_gc_nroots@GOTPAGEOFF]
	ldr	x24, [sp, #96]                  ; 8-byte Folded Reload
	ldr	w22, [sp, #92]                  ; 4-byte Folded Reload
	b.lt	LBB36_36
	b	LBB36_127
LBB36_126:
	mov	x14, x21
LBB36_127:
	str	w22, [x23]
	str	x14, [sp, #136]
	cbz	x14, LBB36_132
; %bb.128:
	ldr	x8, [x14, #8]
	cmp	x8, #1
	b.lt	LBB36_132
; %bb.129:
	ldr	x8, [x14]
	ldr	d0, [x8]
	b	LBB36_133
LBB36_130:
	cmp	x28, x26
	cset	w0, eq
	bl	__sp_main_body.cold.6
LBB36_131:
	cmp	x15, x26
	cset	w0, eq
	bl	__sp_main_body.cold.5
LBB36_132:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_133:
	fmov	x8, d0
	cmp	x8, x26
	b.eq	LBB36_184
; %bb.134:
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d0, d0, d1
	mov	x8, #-4332462841530417152       ; =0xc3e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	mov	x8, #4890909195324358656        ; =0x43e0000000000000
	fmov	d1, x8
	fccmp	d0, d1, #0, ge
	b.pl	LBB36_186
; %bb.135:
	fcvtzs	x0, d0
LBB36_136:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_138
; %bb.137:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	ldr	x8, [sp, #136]
	cbnz	x8, LBB36_139
	b	LBB36_143
LBB36_138:
	str	x0, [sp]
Lloh772:
	adrp	x0, l_.str.21@PAGE
Lloh773:
	add	x0, x0, l_.str.21@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #136]
	cbz	x8, LBB36_143
LBB36_139:
	sub	x9, x24, #1
	ldr	x10, [x8, #8]
	cbnz	x24, LBB36_141
; %bb.140:
	adds	x9, x10, x9
	b.mi	LBB36_143
LBB36_141:
	cmp	x9, x10
	b.ge	LBB36_143
; %bb.142:
	ldr	x8, [x8]
	ldr	d0, [x8, x9, lsl #3]
	b	LBB36_144
LBB36_143:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_144:
	fmov	x8, d0
	cmp	x8, x26
	b.eq	LBB36_185
; %bb.145:
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d0, d0, d1
	mov	x8, #-4332462841530417152       ; =0xc3e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.lt	LBB36_187
; %bb.146:
	mov	x8, #4890909195324358656        ; =0x43e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.pl	LBB36_187
; %bb.147:
	fcvtzs	x0, d0
LBB36_148:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_150
; %bb.149:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	b	LBB36_151
LBB36_150:
	str	x0, [sp]
Lloh774:
	adrp	x0, l_.str.21@PAGE
Lloh775:
	add	x0, x0, l_.str.21@PAGEOFF
	bl	_printf
LBB36_151:
	adrp	x8, __fzl_0@PAGE+24
	ldrb	w8, [x8, __fzl_0@PAGEOFF+24]
	sub	w8, w8, #241
	cmp	w8, #13
	b.hi	LBB36_154
; %bb.152:
	mov	w9, #1                          ; =0x1
	lsl	w8, w9, w8
	mov	w9, #16001                      ; =0x3e81
	tst	w8, w9
	b.eq	LBB36_154
; %bb.153:
Lloh776:
	adrp	x8, __fzl_0@PAGE+12
Lloh777:
	ldr	w19, [x8, __fzl_0@PAGEOFF+12]
	cmn	w19, #1
	b.ne	LBB36_155
LBB36_154:
Lloh778:
	adrp	x0, __fzl_0@PAGE+25
Lloh779:
	add	x0, x0, __fzl_0@PAGEOFF+25
	bl	_strlen
	mov	x19, x0
LBB36_155:
Lloh780:
	adrp	x20, ___stdoutp@GOTPAGE
Lloh781:
	ldr	x20, [x20, ___stdoutp@GOTPAGEOFF]
	ldr	x0, [x20]
	bl	_flockfile
	ldr	x3, [x20]
Lloh782:
	adrp	x0, __fzl_0@PAGE+25
Lloh783:
	add	x0, x0, __fzl_0@PAGEOFF+25
	mov	w1, #1                          ; =0x1
	mov	x2, x19
	bl	_fwrite
	cbz	x19, LBB36_157
; %bb.156:
Lloh784:
	adrp	x8, __fzl_0@PAGE
Lloh785:
	add	x8, x8, __fzl_0@PAGEOFF
	add	x8, x8, x19
	ldrb	w8, [x8, #24]
	cmp	w8, #10
	b.eq	LBB36_161
LBB36_157:
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.le	LBB36_160
; %bb.158:
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	mov	w9, #10                         ; =0xa
	strb	w9, [x8]
	b	LBB36_161
LBB36_159:
	bl	__sp_main_body.cold.8
LBB36_160:
	mov	w0, #10                         ; =0xa
	bl	___swbuf
LBB36_161:
	ldr	x0, [x20]
	bl	_funlockfile
	bl	_sp_get_ARGV
	cbz	x0, LBB36_165
; %bb.162:
	ldr	x8, [x0, #8]
	cmp	x8, #1
	b.lt	LBB36_164
; %bb.163:
	ldr	x8, [x0]
	ldr	x0, [x8]
	b	LBB36_165
LBB36_164:
	mov	x0, #0                          ; =0x0
LBB36_165:
Lloh786:
	adrp	x1, __fzl_1@PAGE+25
Lloh787:
	add	x1, x1, __fzl_1@PAGEOFF+25
	bl	_sp_str_eq
	cbz	w0, LBB36_178
; %bb.166:
	cbz	x24, LBB36_178
; %bb.167:
	mov	x21, #0                         ; =0x0
	mov	w22, #10                        ; =0xa
	b	LBB36_170
	.p2align	6
LBB36_168:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	strb	w22, [x8]
LBB36_169:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x0, [x20]
	bl	_funlockfile
	add	x21, x21, #1
	cmp	x21, x24
	b.ge	LBB36_178
LBB36_170:                              ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #136]
	cbz	x8, LBB36_173
; %bb.171:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x9, [x8, #8]
	cmp	x21, x9
	b.ge	LBB36_173
; %bb.172:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x8, [x8]
	ldr	d0, [x8, x21, lsl #3]
	b	LBB36_174
	.p2align	6
LBB36_173:                              ;   in Loop: Header=BB36_170 Depth=1
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_174:                              ;   in Loop: Header=BB36_170 Depth=1
	bl	_sp_float_opt_to_s
	mov	x19, x0
	ldr	x0, [x20]
	bl	_flockfile
	cbz	x19, LBB36_176
; %bb.175:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x1, [x20]
	mov	x0, x19
	bl	_fputs
LBB36_176:                              ;   in Loop: Header=BB36_170 Depth=1
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.gt	LBB36_168
; %bb.177:                              ;   in Loop: Header=BB36_170 Depth=1
	mov	w0, #10                         ; =0xa
	bl	___swbuf
	b	LBB36_169
LBB36_178:
	bl	_sp_fin_run_exit
	ldr	w8, [sp, #116]                  ; 4-byte Folded Reload
	str	w8, [x23]
	ldp	x29, x30, [sp, #368]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #352]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #336]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #320]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #304]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #288]            ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #272]              ; 16-byte Folded Reload
	add	sp, sp, #384
	ret
LBB36_179:
	bl	__sp_main_body.cold.12
LBB36_180:
	bl	__sp_main_body.cold.16
LBB36_181:
	bl	__sp_main_body.cold.10
LBB36_182:
	bl	__sp_main_body.cold.9
LBB36_183:
	bl	__sp_main_body.cold.7
LBB36_184:
	bl	__sp_main_body.cold.3
LBB36_185:
	bl	__sp_main_body.cold.2
LBB36_186:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_136
LBB36_187:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_148
LBB36_188:
	bl	__sp_main_body.cold.11
LBB36_189:
	bl	__sp_main_body.cold.15
LBB36_190:
	bl	__sp_main_body.cold.14
LBB36_191:
	bl	__sp_main_body.cold.13
LBB36_192:
	bl	__sp_main_body.cold.4
LBB36_193:
	mov	x0, x20
	bl	_sp_raise_frozen_array_at
LBB36_194:
	mov	x1, x22
	bl	__sp_main_body.cold.1
	.loh AdrpAdd	Lloh598, Lloh599
	.loh AdrpLdrGot	Lloh596, Lloh597
	.loh AdrpLdrGot	Lloh600, Lloh601
	.loh AdrpLdrGotLdr	Lloh602, Lloh603, Lloh604
	.loh AdrpAdd	Lloh667, Lloh668
	.loh AdrpLdrGot	Lloh665, Lloh666
	.loh AdrpAdd	Lloh663, Lloh664
	.loh AdrpLdrGot	Lloh661, Lloh662
	.loh AdrpAdd	Lloh659, Lloh660
	.loh AdrpLdrGot	Lloh657, Lloh658
	.loh AdrpAdd	Lloh655, Lloh656
	.loh AdrpLdrGot	Lloh653, Lloh654
	.loh AdrpAdd	Lloh651, Lloh652
	.loh AdrpLdrGot	Lloh649, Lloh650
	.loh AdrpAdd	Lloh647, Lloh648
	.loh AdrpAdd	Lloh645, Lloh646
	.loh AdrpAdd	Lloh643, Lloh644
	.loh AdrpLdrGot	Lloh641, Lloh642
	.loh AdrpAdd	Lloh639, Lloh640
	.loh AdrpLdrGot	Lloh637, Lloh638
	.loh AdrpAdd	Lloh635, Lloh636
	.loh AdrpLdrGot	Lloh633, Lloh634
	.loh AdrpAdd	Lloh631, Lloh632
	.loh AdrpAdd	Lloh629, Lloh630
	.loh AdrpAdd	Lloh627, Lloh628
	.loh AdrpLdrGot	Lloh625, Lloh626
	.loh AdrpAdd	Lloh623, Lloh624
	.loh AdrpAdd	Lloh621, Lloh622
	.loh AdrpAdd	Lloh619, Lloh620
	.loh AdrpAdd	Lloh617, Lloh618
	.loh AdrpAdd	Lloh615, Lloh616
	.loh AdrpAdd	Lloh613, Lloh614
	.loh AdrpAdd	Lloh611, Lloh612
	.loh AdrpAdd	Lloh609, Lloh610
	.loh AdrpAdd	Lloh607, Lloh608
	.loh AdrpAdd	Lloh605, Lloh606
	.loh AdrpLdr	Lloh724, Lloh725
	.loh AdrpLdrGot	Lloh722, Lloh723
	.loh AdrpLdr	Lloh720, Lloh721
	.loh AdrpAdd	Lloh717, Lloh718
	.loh AdrpLdrGotStr	Lloh715, Lloh716, Lloh719
	.loh AdrpAdd	Lloh711, Lloh712
	.loh AdrpLdrGotStr	Lloh709, Lloh710, Lloh714
	.loh AdrpAdd	Lloh707, Lloh708
	.loh AdrpLdrGotStr	Lloh705, Lloh706, Lloh713
	.loh AdrpAdd	Lloh702, Lloh703
	.loh AdrpLdrGotStr	Lloh699, Lloh700, Lloh704
	.loh AdrpAdd	Lloh697, Lloh698
	.loh AdrpLdrGotStr	Lloh695, Lloh696, Lloh701
	.loh AdrpAdd	Lloh692, Lloh693
	.loh AdrpLdrGotStr	Lloh690, Lloh691, Lloh694
	.loh AdrpAdrp	Lloh689, Lloh692
	.loh AdrpAdd	Lloh687, Lloh688
	.loh AdrpAdd	Lloh684, Lloh685
	.loh AdrpLdrGotStr	Lloh682, Lloh683, Lloh686
	.loh AdrpAdrp	Lloh681, Lloh684
	.loh AdrpAdd	Lloh679, Lloh680
	.loh AdrpAdd	Lloh676, Lloh677
	.loh AdrpLdrGotStr	Lloh674, Lloh675, Lloh678
	.loh AdrpAdd	Lloh671, Lloh672
	.loh AdrpLdrGotStr	Lloh669, Lloh670, Lloh673
	.loh AdrpLdrGot	Lloh730, Lloh731
	.loh AdrpLdrGot	Lloh728, Lloh729
	.loh AdrpLdrGot	Lloh726, Lloh727
	.loh AdrpLdrGotLdr	Lloh732, Lloh733, Lloh734
	.loh AdrpLdrGotLdr	Lloh738, Lloh739, Lloh740
	.loh AdrpLdrGotLdr	Lloh735, Lloh736, Lloh737
	.loh AdrpLdrGotLdr	Lloh741, Lloh742, Lloh743
	.loh AdrpLdrGotLdr	Lloh744, Lloh745, Lloh746
	.loh AdrpAdd	Lloh747, Lloh748
	.loh AdrpLdrGotStr	Lloh755, Lloh756, Lloh757
	.loh AdrpLdrGotStr	Lloh752, Lloh753, Lloh754
	.loh AdrpLdrGotStr	Lloh749, Lloh750, Lloh751
	.loh AdrpLdrGot	Lloh762, Lloh763
	.loh AdrpAdd	Lloh760, Lloh761
	.loh AdrpAdd	Lloh758, Lloh759
	.loh AdrpLdrGot	Lloh764, Lloh765
	.loh AdrpAdd	Lloh766, Lloh767
	.loh AdrpLdrGot	Lloh768, Lloh769
	.loh AdrpLdrGot	Lloh770, Lloh771
	.loh AdrpAdd	Lloh772, Lloh773
	.loh AdrpAdd	Lloh774, Lloh775
	.loh AdrpLdr	Lloh776, Lloh777
	.loh AdrpAdd	Lloh778, Lloh779
	.loh AdrpAdd	Lloh782, Lloh783
	.loh AdrpLdrGot	Lloh780, Lloh781
	.loh AdrpAdd	Lloh784, Lloh785
	.loh AdrpAdd	Lloh786, Lloh787

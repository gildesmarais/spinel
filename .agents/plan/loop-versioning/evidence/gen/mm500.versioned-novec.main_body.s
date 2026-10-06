__sp_main_body:                         ; @_sp_main_body
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #288
	stp	d9, d8, [sp, #176]              ; 16-byte Folded Spill
	stp	x28, x27, [sp, #192]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #208]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #224]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #240]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #256]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #272]            ; 16-byte Folded Spill
	add	x29, sp, #272
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
Lloh586:
	adrp	x9, _sp_gc_nroots@GOTPAGE
Lloh587:
	ldr	x9, [x9, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w10, [x9]
Lloh588:
	adrp	x8, l___const._sp_main_body._gcf@PAGE
Lloh589:
	add	x8, x8, l___const._sp_main_body._gcf@PAGEOFF
	ldp	q0, q1, [x8]
	stp	q0, q1, [sp, #64]
	add	x8, sp, #64
	orr	x0, x8, #0x3
Lloh590:
	adrp	x11, _sp_gc_roots@GOTPAGE
Lloh591:
	ldr	x11, [x11, _sp_gc_roots@GOTPAGEOFF]
	cmp	w10, #16, lsl #12               ; =65536
	str	w10, [sp, #32]                  ; 4-byte Folded Spill
	b.ge	LBB36_2
; %bb.1:
	add	w8, w10, #1
	str	w8, [x9]
	str	x0, [x11, w10, sxtw #3]
	b	LBB36_3
LBB36_2:
	bl	_sp_gc_root_push_slow
LBB36_3:
Lloh592:
	adrp	x8, _sp_alloc_report_on@GOTPAGE
Lloh593:
	ldr	x8, [x8, _sp_alloc_report_on@GOTPAGEOFF]
Lloh594:
	ldr	w8, [x8]
	cbz	w8, LBB36_5
; %bb.4:
Lloh595:
	adrp	x0, _sp_PolyArray_scan@PAGE
Lloh596:
	add	x0, x0, _sp_PolyArray_scan@PAGEOFF
Lloh597:
	adrp	x1, l_.str.199@PAGE
Lloh598:
	add	x1, x1, l_.str.199@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh599:
	adrp	x0, _sp_StrArray_scan@PAGE
Lloh600:
	add	x0, x0, _sp_StrArray_scan@PAGEOFF
Lloh601:
	adrp	x1, l_.str.200@PAGE
Lloh602:
	add	x1, x1, l_.str.200@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh603:
	adrp	x0, _sp_SymPolyHash_scan@PAGE
Lloh604:
	add	x0, x0, _sp_SymPolyHash_scan@PAGEOFF
Lloh605:
	adrp	x1, l_.str.201@PAGE
Lloh606:
	add	x1, x1, l_.str.201@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh607:
	adrp	x0, _sp_StrPolyHash_scan@PAGE
Lloh608:
	add	x0, x0, _sp_StrPolyHash_scan@PAGEOFF
Lloh609:
	adrp	x1, l_.str.202@PAGE
Lloh610:
	add	x1, x1, l_.str.202@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh611:
	adrp	x0, _sp_PolyPolyHash_scan@PAGE
Lloh612:
	add	x0, x0, _sp_PolyPolyHash_scan@PAGEOFF
Lloh613:
	adrp	x1, l_.str.203@PAGE
Lloh614:
	add	x1, x1, l_.str.203@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh615:
	adrp	x0, _sp_Enumerator_scan@GOTPAGE
Lloh616:
	ldr	x0, [x0, _sp_Enumerator_scan@GOTPAGEOFF]
Lloh617:
	adrp	x1, l_.str.204@PAGE
Lloh618:
	add	x1, x1, l_.str.204@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh619:
	adrp	x0, _sp_OpenStruct_scan@PAGE
Lloh620:
	add	x0, x0, _sp_OpenStruct_scan@PAGEOFF
Lloh621:
	adrp	x1, l_.str.205@PAGE
Lloh622:
	add	x1, x1, l_.str.205@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh623:
	adrp	x0, _sp_Dir_scan@GOTPAGE
Lloh624:
	ldr	x0, [x0, _sp_Dir_scan@GOTPAGEOFF]
Lloh625:
	adrp	x1, l_.str.206@PAGE
Lloh626:
	add	x1, x1, l_.str.206@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh627:
	adrp	x0, _sp_Proc_scan@GOTPAGE
Lloh628:
	ldr	x0, [x0, _sp_Proc_scan@GOTPAGEOFF]
Lloh629:
	adrp	x1, l_.str.207@PAGE
Lloh630:
	add	x1, x1, l_.str.207@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh631:
	adrp	x0, _sp_exc_gc_scan@GOTPAGE
Lloh632:
	ldr	x0, [x0, _sp_exc_gc_scan@GOTPAGEOFF]
Lloh633:
	adrp	x1, l_.str.208@PAGE
Lloh634:
	add	x1, x1, l_.str.208@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh635:
	adrp	x0, _sp_PtrArray_gc_scan@PAGE
Lloh636:
	add	x0, x0, _sp_PtrArray_gc_scan@PAGEOFF
Lloh637:
	adrp	x1, l_.str.209@PAGE
Lloh638:
	add	x1, x1, l_.str.209@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh639:
	adrp	x0, _sp_StrIntHash_scan@GOTPAGE
Lloh640:
	ldr	x0, [x0, _sp_StrIntHash_scan@GOTPAGEOFF]
Lloh641:
	adrp	x1, l_.str.210@PAGE
Lloh642:
	add	x1, x1, l_.str.210@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh643:
	adrp	x0, _sp_StrStrHash_scan@GOTPAGE
Lloh644:
	ldr	x0, [x0, _sp_StrStrHash_scan@GOTPAGEOFF]
Lloh645:
	adrp	x1, l_.str.211@PAGE
Lloh646:
	add	x1, x1, l_.str.211@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh647:
	adrp	x0, _sp_IntStrHash_scan@GOTPAGE
Lloh648:
	ldr	x0, [x0, _sp_IntStrHash_scan@GOTPAGEOFF]
Lloh649:
	adrp	x1, l_.str.212@PAGE
Lloh650:
	add	x1, x1, l_.str.212@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh651:
	adrp	x0, _sp_curry_scan@GOTPAGE
Lloh652:
	ldr	x0, [x0, _sp_curry_scan@GOTPAGEOFF]
Lloh653:
	adrp	x1, l_.str.213@PAGE
Lloh654:
	add	x1, x1, l_.str.213@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh655:
	adrp	x0, _sp_BoundMethod_scan@GOTPAGE
Lloh656:
	ldr	x0, [x0, _sp_BoundMethod_scan@GOTPAGEOFF]
Lloh657:
	adrp	x1, l_.str.214@PAGE
Lloh658:
	add	x1, x1, l_.str.214@PAGEOFF
	bl	_sp_alloc_report_tag
LBB36_5:
Lloh659:
	adrp	x8, _sp_sym_name_fn@GOTPAGE
Lloh660:
	ldr	x8, [x8, _sp_sym_name_fn@GOTPAGEOFF]
Lloh661:
	adrp	x9, _sp_sym_to_s@PAGE
Lloh662:
	add	x9, x9, _sp_sym_to_s@PAGEOFF
Lloh663:
	str	x9, [x8]
Lloh664:
	adrp	x8, _sp_stack_overflow_raise_fn@GOTPAGE
Lloh665:
	ldr	x8, [x8, _sp_stack_overflow_raise_fn@GOTPAGEOFF]
Lloh666:
	adrp	x9, _sp_raise_stack_overflow@PAGE
Lloh667:
	add	x9, x9, _sp_raise_stack_overflow@PAGEOFF
Lloh668:
	str	x9, [x8]
	bl	_sp_stack_guard_init
Lloh669:
	adrp	x8, _sp_user_exc_parent@PAGE
Lloh670:
	add	x8, x8, _sp_user_exc_parent@PAGEOFF
Lloh671:
	adrp	x9, _sp_user_exc_parent_fn@PAGE
	str	x8, [x9, _sp_user_exc_parent_fn@PAGEOFF]
Lloh672:
	adrp	x8, _sp_user_exc_modules_fn@GOTPAGE
Lloh673:
	ldr	x8, [x8, _sp_user_exc_modules_fn@GOTPAGEOFF]
Lloh674:
	adrp	x9, _sp_user_exc_modules@PAGE
Lloh675:
	add	x9, x9, _sp_user_exc_modules@PAGEOFF
Lloh676:
	str	x9, [x8]
Lloh677:
	adrp	x8, _sp_poly_is_a@PAGE
Lloh678:
	add	x8, x8, _sp_poly_is_a@PAGEOFF
Lloh679:
	adrp	x9, _sp_poly_is_a_hook@PAGE
	str	x8, [x9, _sp_poly_is_a_hook@PAGEOFF]
Lloh680:
	adrp	x8, _sp_class_le_id_fn@GOTPAGE
Lloh681:
	ldr	x8, [x8, _sp_class_le_id_fn@GOTPAGEOFF]
Lloh682:
	adrp	x9, _sp_class_le_ids@PAGE
Lloh683:
	add	x9, x9, _sp_class_le_ids@PAGEOFF
Lloh684:
	str	x9, [x8]
Lloh685:
	adrp	x8, _sp_class_cmp_fn@GOTPAGE
Lloh686:
	ldr	x8, [x8, _sp_class_cmp_fn@GOTPAGEOFF]
Lloh687:
	adrp	x9, _sp_class_cmp_rv@PAGE
Lloh688:
	add	x9, x9, _sp_class_cmp_rv@PAGEOFF
Lloh689:
	adrp	x10, _sp_class_kind_of_name_fn@GOTPAGE
Lloh690:
	ldr	x10, [x10, _sp_class_kind_of_name_fn@GOTPAGEOFF]
Lloh691:
	str	x9, [x8]
Lloh692:
	adrp	x8, _sp_class_kind_of_name@PAGE
Lloh693:
	add	x8, x8, _sp_class_kind_of_name@PAGEOFF
Lloh694:
	str	x8, [x10]
Lloh695:
	adrp	x8, _sp_class_is_module_fn@GOTPAGE
Lloh696:
	ldr	x8, [x8, _sp_class_is_module_fn@GOTPAGEOFF]
Lloh697:
	adrp	x9, _sp_class_is_module_val@PAGE
Lloh698:
	add	x9, x9, _sp_class_is_module_val@PAGEOFF
Lloh699:
	adrp	x10, _sp_gc_mark_globals_hook@GOTPAGE
Lloh700:
	ldr	x10, [x10, _sp_gc_mark_globals_hook@GOTPAGEOFF]
Lloh701:
	adrp	x11, _sp_mark_user_globals@PAGE
Lloh702:
	add	x11, x11, _sp_mark_user_globals@PAGEOFF
Lloh703:
	str	x9, [x8]
Lloh704:
	str	x11, [x10]
Lloh705:
	adrp	x8, _sp_json_sym_intern_fn@GOTPAGE
Lloh706:
	ldr	x8, [x8, _sp_json_sym_intern_fn@GOTPAGEOFF]
Lloh707:
	adrp	x9, _sp_sym_intern@PAGE
Lloh708:
	add	x9, x9, _sp_sym_intern@PAGEOFF
Lloh709:
	str	x9, [x8]
Lloh710:
	adrp	x8, __sp_main_argc@PAGE
Lloh711:
	ldr	w21, [x8, __sp_main_argc@PAGEOFF]
	subs	w19, w21, #1
Lloh712:
	adrp	x22, _sp_argv@GOTPAGE
Lloh713:
	ldr	x22, [x22, _sp_argv@GOTPAGEOFF]
	sxtw	x8, w19
	str	x8, [x22, #8]
	csinc	w8, w19, wzr, gt
	ubfiz	x0, x8, #3, #32
Lloh714:
	adrp	x8, __sp_main_argv@PAGE
Lloh715:
	ldr	x20, [x8, __sp_main_argv@PAGEOFF]
	bl	_malloc
	str	x0, [x22]
	cmp	w21, #2
	b.lt	LBB36_22
; %bb.6:
	mov	x27, #0                         ; =0x0
	ubfiz	x28, x19, #3, #32
	add	x24, x20, #8
Lloh716:
	adrp	x19, _sp_str_stress_checked@GOTPAGE
Lloh717:
	ldr	x19, [x19, _sp_str_stress_checked@GOTPAGEOFF]
Lloh718:
	adrp	x26, _sp_str_heap_bytes@GOTPAGE
Lloh719:
	ldr	x26, [x26, _sp_str_heap_bytes@GOTPAGEOFF]
Lloh720:
	adrp	x25, _sp_str_heap@GOTPAGE
Lloh721:
	ldr	x25, [x25, _sp_str_heap@GOTPAGEOFF]
	b	LBB36_9
	.p2align	6
LBB36_7:                                ;   in Loop: Header=BB36_9 Depth=1
	mov	x22, #0                         ; =0x0
LBB36_8:                                ;   in Loop: Header=BB36_9 Depth=1
	str	x22, [x0, x27]
	add	x27, x27, #8
	cmp	x28, x27
	b.eq	LBB36_22
LBB36_9:                                ; =>This Inner Loop Header: Depth=1
	ldr	x20, [x24, x27]
	cbz	x20, LBB36_7
; %bb.10:                               ;   in Loop: Header=BB36_9 Depth=1
	mov	x0, x20
	bl	_strlen
	mov	x21, x0
	ldr	w8, [x19]
	cbz	w8, LBB36_18
LBB36_11:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x26]
Lloh722:
	adrp	x9, _sp_str_threshold@GOTPAGE
Lloh723:
	ldr	x9, [x9, _sp_str_threshold@GOTPAGEOFF]
Lloh724:
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
Lloh725:
	adrp	x8, _sp_slab_base@GOTPAGE
Lloh726:
	ldr	x8, [x8, _sp_slab_base@GOTPAGEOFF]
Lloh727:
	ldr	x8, [x8]
Lloh728:
	adrp	x9, _sp_slab_cap@GOTPAGE
Lloh729:
	ldr	x9, [x9, _sp_slab_cap@GOTPAGEOFF]
Lloh730:
	ldr	x9, [x9]
	sub	x8, x0, x8
	cmp	x8, x9
	b.lo	LBB36_15
; %bb.14:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x25]
	str	x8, [x22]
	str	x22, [x25]
LBB36_15:                               ;   in Loop: Header=BB36_9 Depth=1
	ldr	x8, [x26]
	add	x8, x8, x23
	str	x8, [x26]
	mov	x8, x22
	mov	w9, #254                        ; =0xfe
	strb	w9, [x8, #24]!
	add	x8, x8, x21
	strb	wzr, [x8, #1]
Lloh731:
	adrp	x8, _sp_alloc_report_on@GOTPAGE
Lloh732:
	ldr	x8, [x8, _sp_alloc_report_on@GOTPAGEOFF]
Lloh733:
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
Lloh734:
	adrp	x8, _sp_argv@GOTPAGE
Lloh735:
	ldr	x8, [x8, _sp_argv@GOTPAGEOFF]
Lloh736:
	ldr	x0, [x8]
	b	LBB36_8
	.p2align	6
LBB36_18:                               ;   in Loop: Header=BB36_9 Depth=1
	mov	w8, #1                          ; =0x1
	str	w8, [x19]
Lloh737:
	adrp	x0, l_.str.46@PAGE
Lloh738:
	add	x0, x0, l_.str.46@PAGEOFF
	bl	_getenv
	cbz	x0, LBB36_11
; %bb.19:                               ;   in Loop: Header=BB36_9 Depth=1
	ldrb	w8, [x0]
	cbz	w8, LBB36_11
; %bb.20:                               ;   in Loop: Header=BB36_9 Depth=1
	cmp	w8, #48
	b.eq	LBB36_11
; %bb.21:                               ;   in Loop: Header=BB36_9 Depth=1
Lloh739:
	adrp	x8, _sp_str_threshold@GOTPAGE
Lloh740:
	ldr	x8, [x8, _sp_str_threshold@GOTPAGEOFF]
	mov	w9, #2048                       ; =0x800
Lloh741:
	str	x9, [x8]
Lloh742:
	adrp	x8, _sp_str_threshold_init@GOTPAGE
Lloh743:
	ldr	x8, [x8, _sp_str_threshold_init@GOTPAGEOFF]
Lloh744:
	str	x9, [x8]
	mov	w8, #1                          ; =0x1
Lloh745:
	adrp	x9, _sp_gc_stress_pin@GOTPAGE
Lloh746:
	ldr	x9, [x9, _sp_gc_stress_pin@GOTPAGEOFF]
Lloh747:
	str	w8, [x9]
	b	LBB36_11
LBB36_22:
	stp	xzr, xzr, [sp, #48]
	add	x8, sp, #56
	add	x9, sp, #48
	stp	x8, x9, [sp, #72]
	str	xzr, [sp, #40]
	add	x8, sp, #40
	str	x8, [sp, #88]
	bl	_sp_matgen
	str	x0, [sp, #56]
	bl	_sp_matgen
	str	x0, [sp, #48]
	ldr	x8, [sp, #56]
	stp	x0, x8, [x29, #-120]
Lloh748:
	adrp	x9, _sp_gc_nroots@GOTPAGE
Lloh749:
	ldr	x9, [x9, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w10, [x9]
	movi.2d	v0, #0000000000000000
	str	xzr, [sp, #144]
	stp	q0, q0, [sp, #112]
	mov	w8, #4                          ; =0x4
	str	w8, [sp, #116]
	add	x8, sp, #112
	orr	x0, x8, #0x3
	cmp	w10, #16, lsl #12               ; =65536
	str	w10, [sp, #36]                  ; 4-byte Folded Spill
	b.ge	LBB36_24
; %bb.23:
	add	w8, w10, #1
	str	w8, [x9]
Lloh750:
	adrp	x8, _sp_gc_roots@GOTPAGE
Lloh751:
	ldr	x8, [x8, _sp_gc_roots@GOTPAGEOFF]
	str	x0, [x8, w10, sxtw #3]
	b	LBB36_25
LBB36_24:
	bl	_sp_gc_root_push_slow
LBB36_25:
	mov	w19, #53392                     ; =0xd090
	movk	w19, #3, lsl #16
	sub	x8, x29, #112
	sub	x9, x29, #120
	stp	x8, x9, [sp, #120]
	str	xzr, [sp, #104]
	add	x8, sp, #104
	str	x8, [sp, #136]
Lloh752:
	adrp	x1, _sp_FloatArray_fin@PAGE
Lloh753:
	add	x1, x1, _sp_FloatArray_fin@PAGEOFF
	mov	w0, #40                         ; =0x28
	mov	x2, #0                          ; =0x0
	bl	_sp_gc_alloc
	mov	x20, x0
	str	x19, [x0, #16]
	mov	w0, #33920                      ; =0x8480
	movk	w0, #30, lsl #16
	bl	_sp_slab_alloc_raw
	str	x0, [x20]
	cbnz	x0, LBB36_27
; %bb.26:
	bl	_sp_oom_die
	ldr	x0, [x20]
LBB36_27:
	mov	x23, #1                         ; =0x1
	movk	x23, #32760, lsl #48
	mov	w1, #33920                      ; =0x8480
	movk	w1, #30, lsl #16
	bl	_bzero
	mov	x17, #0                         ; =0x0
	mov	x0, #0                          ; =0x0
	str	x19, [x20, #8]
	ldr	x8, [x20, #16]
	lsl	x8, x8, #3
	ldur	x9, [x20, #-24]
	add	x9, x9, x8
Lloh754:
	adrp	x10, _sp_gc_bytes@GOTPAGE
Lloh755:
	ldr	x10, [x10, _sp_gc_bytes@GOTPAGEOFF]
	stur	x9, [x20, #-24]
	ldr	x9, [x10]
	add	x8, x9, x8
	str	x8, [x10]
	stp	x20, x20, [sp, #96]
	add	x8, sp, #96
	str	x8, [sp, #144]
	mov	w1, #500                        ; =0x1f4
	mov	x2, #500                        ; =0x1f4
	mov	w3, #1                          ; =0x1
	mov	x19, x20
LBB36_28:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB36_30 Depth 2
                                        ;       Child Loop BB36_84 Depth 3
                                        ;       Child Loop BB36_42 Depth 3
                                        ;         Child Loop BB36_66 Depth 4
	mov	x25, #0                         ; =0x0
	mov	x22, #0                         ; =0x0
	mul	x26, x0, x1
	add	x4, x26, #500
	b	LBB36_30
	.p2align	6
LBB36_29:                               ;   in Loop: Header=BB36_30 Depth=2
	add	x22, x22, #1
	add	x25, x25, #4000
	cmp	x22, #500
	b.eq	LBB36_86
LBB36_30:                               ;   Parent Loop BB36_28 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB36_84 Depth 3
                                        ;       Child Loop BB36_42 Depth 3
                                        ;         Child Loop BB36_66 Depth 4
	ldur	x8, [x29, #-112]
	cbz	x8, LBB36_35
; %bb.31:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	x10, [x8, #8]
	add	x9, x22, x26
	cmp	x9, x10
	b.ge	LBB36_35
; %bb.32:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	x8, [x8]
	ldr	d8, [x8, x9, lsl #3]
	cbnz	x20, LBB36_36
LBB36_33:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x9, #0                          ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w10, #0                         ; =0x0
	ldur	x11, [x29, #-120]
	cbnz	x11, LBB36_37
LBB36_34:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x12, #0                         ; =0x0
	mov	x13, #0                         ; =0x0
	cbnz	x20, LBB36_38
	b	LBB36_41
	.p2align	6
LBB36_35:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d8, x8
	cbz	x20, LBB36_33
LBB36_36:                               ;   in Loop: Header=BB36_30 Depth=2
	ldp	x8, x9, [x20]
	ldr	x10, [x20, #24]
	cmp	x10, #0
	cset	w10, eq
	ldur	x11, [x29, #-120]
	cbz	x11, LBB36_34
LBB36_37:                               ;   in Loop: Header=BB36_30 Depth=2
	ldp	x12, x13, [x11]
	cbz	x20, LBB36_41
LBB36_38:                               ;   in Loop: Header=BB36_30 Depth=2
	cbz	x8, LBB36_41
; %bb.39:                               ;   in Loop: Header=BB36_30 Depth=2
	cbz	w10, LBB36_41
; %bb.40:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	w14, [x20, #32]
	cbz	w14, LBB36_77
LBB36_41:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x27, #0                         ; =0x0
	mul	x24, x22, x1
	fmov	x28, d8
	mov	x14, x20
	.p2align	6
LBB36_42:                               ;   Parent Loop BB36_28 Depth=1
                                        ;     Parent Loop BB36_30 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB36_66 Depth 4
	add	x21, x27, x26
	cmp	x21, x9
	mov	x15, x8
	b.lo	LBB36_46
; %bb.43:                               ;   in Loop: Header=BB36_42 Depth=3
	cbz	x19, LBB36_47
; %bb.44:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x14, [x19, #8]
	cmp	x21, x14
	b.ge	LBB36_48
; %bb.45:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x15, [x19]
	mov	x20, x19
	mov	x14, x19
LBB36_46:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	d0, [x15, x21, lsl #3]
	b	LBB36_49
LBB36_47:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x20, #0                         ; =0x0
	mov	x14, #0                         ; =0x0
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d0, x15
	b	LBB36_49
LBB36_48:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x14, #1                         ; =0x1
	movk	x14, #32760, lsl #48
	fmov	d0, x14
	mov	x20, x19
	mov	x14, x19
	.p2align	6
LBB36_49:                               ;   in Loop: Header=BB36_42 Depth=3
	add	x15, x27, x24
	cmp	x15, x13
	mov	x16, x12
	b.lo	LBB36_53
; %bb.50:                               ;   in Loop: Header=BB36_42 Depth=3
	cbz	x11, LBB36_54
; %bb.51:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x16, [x11, #8]
	cmp	x15, x16
	b.ge	LBB36_54
; %bb.52:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x16, [x11]
LBB36_53:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	d1, [x16, x15, lsl #3]
	cmp	x28, x23
	b.ne	LBB36_55
	b	LBB36_90
	.p2align	6
LBB36_54:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d1, x15
	cmp	x28, x23
	b.eq	LBB36_90
LBB36_55:                               ;   in Loop: Header=BB36_42 Depth=3
	fmov	x15, d1
	cmp	x15, x23
	b.eq	LBB36_90
; %bb.56:                               ;   in Loop: Header=BB36_42 Depth=3
	fmov	x15, d0
	cmp	x15, x23
	b.eq	LBB36_91
; %bb.57:                               ;   in Loop: Header=BB36_42 Depth=3
	fmul	d1, d8, d1
	fmov	x16, d1
	cmp	x16, x23
	b.eq	LBB36_91
; %bb.58:                               ;   in Loop: Header=BB36_42 Depth=3
	fadd	d9, d0, d1
	cmp	x21, x9
	b.hs	LBB36_62
; %bb.59:                               ;   in Loop: Header=BB36_42 Depth=3
	cbz	w10, LBB36_62
; %bb.60:                               ;   in Loop: Header=BB36_42 Depth=3
	str	d9, [x8, x21, lsl #3]
	mov	w10, #1                         ; =0x1
LBB36_61:                               ;   in Loop: Header=BB36_42 Depth=3
	add	x27, x27, #1
	cmp	x27, #500
	b.ne	LBB36_42
	b	LBB36_29
LBB36_62:                               ;   in Loop: Header=BB36_42 Depth=3
	cbz	x19, LBB36_70
; %bb.63:                               ;   in Loop: Header=BB36_42 Depth=3
	stp	x4, x0, [sp, #16]               ; 16-byte Folded Spill
	ldr	x8, [x19, #24]
	cbnz	x8, LBB36_140
; %bb.64:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x20, x17
	ldr	x8, [x19, #16]
	cmp	x21, x8
	b.lt	LBB36_67
; %bb.65:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x0, [x19]
	.p2align	6
LBB36_66:                               ;   Parent Loop BB36_28 Depth=1
                                        ;     Parent Loop BB36_30 Depth=2
                                        ;       Parent Loop BB36_42 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	orr	x8, x3, x8, lsl #1
	str	x8, [x19, #16]
	lsl	x1, x8, #3
	bl	_sp_pl_realloc
	mov	w3, #1                          ; =0x1
	str	x0, [x19]
	ldr	x8, [x19, #16]
	cmp	x21, x8
	b.ge	LBB36_66
LBB36_67:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x8, [x19, #8]
	cmp	x21, x8
	b.ge	LBB36_76
LBB36_68:                               ;   in Loop: Header=BB36_42 Depth=3
	ldr	x8, [x19]
	str	d9, [x8, x21, lsl #3]
	ldr	x19, [sp, #104]
	cbz	x19, LBB36_72
; %bb.69:                               ;   in Loop: Header=BB36_42 Depth=3
	ldp	x8, x9, [x19]
	ldr	x10, [x19, #24]
	cmp	x10, #0
	cset	w10, eq
	b	LBB36_73
LBB36_70:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x9, #0                          ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w10, #0                         ; =0x0
	ldur	x11, [x29, #-120]
	cbnz	x11, LBB36_74
LBB36_71:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x13, #0                         ; =0x0
	mov	x12, #0                         ; =0x0
	b	LBB36_75
LBB36_72:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x9, #0                          ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w10, #0                         ; =0x0
LBB36_73:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x17, x20
	ldp	x4, x0, [sp, #16]               ; 16-byte Folded Reload
	mov	w1, #500                        ; =0x1f4
	mov	x2, #500                        ; =0x1f4
	ldur	x11, [x29, #-120]
	cbz	x11, LBB36_71
LBB36_74:                               ;   in Loop: Header=BB36_42 Depth=3
	ldp	x12, x13, [x11]
LBB36_75:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x20, x19
	mov	x14, x19
	b	LBB36_61
LBB36_76:                               ;   in Loop: Header=BB36_42 Depth=3
	mov	x0, x19
	mov	x1, x21
	bl	_sp_FloatArray_fill_to
	mov	w3, #1                          ; =0x1
	b	LBB36_68
LBB36_77:                               ;   in Loop: Header=BB36_30 Depth=2
	cmp	x4, x9
	b.gt	LBB36_41
; %bb.78:                               ;   in Loop: Header=BB36_30 Depth=2
	cbz	x11, LBB36_41
; %bb.79:                               ;   in Loop: Header=BB36_30 Depth=2
	cbz	x12, LBB36_41
; %bb.80:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	w14, [x11, #32]
	cbnz	w14, LBB36_41
; %bb.81:                               ;   in Loop: Header=BB36_30 Depth=2
	madd	x14, x22, x1, x2
	cmp	x14, x13
	b.gt	LBB36_41
; %bb.82:                               ;   in Loop: Header=BB36_30 Depth=2
	fmov	x14, d8
	cmp	x14, x23
	b.eq	LBB36_41
; %bb.83:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x9, #0                          ; =0x0
	add	x10, x12, x25
	add	x8, x8, x17
	.p2align	6
LBB36_84:                               ;   Parent Loop BB36_28 Depth=1
                                        ;     Parent Loop BB36_30 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	d0, [x8, x9]
	ldr	d1, [x10, x9]
	fmul	d1, d8, d1
	fadd	d0, d0, d1
	str	d0, [x8, x9]
	add	x9, x9, #8
	cmp	x9, #4000
	b.ne	LBB36_84
; %bb.85:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x14, x20
	b	LBB36_29
	.p2align	6
LBB36_86:                               ;   in Loop: Header=BB36_28 Depth=1
	add	x0, x0, #1
	add	x17, x17, #4000
	cmp	x0, #500
	b.ne	LBB36_28
; %bb.87:
Lloh756:
	adrp	x24, _sp_gc_nroots@GOTPAGE
Lloh757:
	ldr	x24, [x24, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w8, [sp, #36]                   ; 4-byte Folded Reload
	str	w8, [x24]
	str	x14, [sp, #40]
	cbz	x14, LBB36_92
; %bb.88:
	ldr	x8, [x14, #8]
	cmp	x8, #1
	b.lt	LBB36_92
; %bb.89:
	ldr	x8, [x14]
	ldr	d0, [x8]
	b	LBB36_93
LBB36_90:
	cmp	x28, x23
	cset	w0, eq
	bl	__sp_main_body.cold.4
LBB36_91:
	cmp	x15, x23
	cset	w0, eq
	bl	__sp_main_body.cold.3
LBB36_92:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_93:
	fmov	x8, d0
	cmp	x8, x23
	b.eq	LBB36_136
; %bb.94:
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
	mov	w25, #53392                     ; =0xd090
	movk	w25, #3, lsl #16
	b.pl	LBB36_138
; %bb.95:
	fcvtzs	x0, d0
LBB36_96:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_98
; %bb.97:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	b	LBB36_99
LBB36_98:
	str	x0, [sp]
Lloh758:
	adrp	x0, l_.str.19@PAGE
Lloh759:
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_printf
LBB36_99:
	ldr	x8, [sp, #40]
	cbz	x8, LBB36_102
; %bb.100:
	ldr	x9, [x8, #8]
	sub	x10, x25, #1
	cmp	x9, x10
	b.le	LBB36_102
; %bb.101:
	ldr	x8, [x8]
	add	x9, x8, #488, lsl #12           ; =1998848
	ldr	d0, [x9, #1144]
	b	LBB36_103
LBB36_102:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_103:
	fmov	x8, d0
	cmp	x8, x23
	b.eq	LBB36_137
; %bb.104:
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d0, d0, d1
	mov	x8, #-4332462841530417152       ; =0xc3e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.lt	LBB36_139
; %bb.105:
	mov	x8, #4890909195324358656        ; =0x43e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.pl	LBB36_139
; %bb.106:
	fcvtzs	x0, d0
LBB36_107:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_109
; %bb.108:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	b	LBB36_110
LBB36_109:
	str	x0, [sp]
Lloh760:
	adrp	x0, l_.str.19@PAGE
Lloh761:
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_printf
LBB36_110:
	adrp	x8, __fzl_0@PAGE+24
	ldrb	w8, [x8, __fzl_0@PAGEOFF+24]
	sub	w8, w8, #241
	cmp	w8, #13
	b.hi	LBB36_113
; %bb.111:
	mov	w9, #1                          ; =0x1
	lsl	w8, w9, w8
	mov	w9, #16001                      ; =0x3e81
	tst	w8, w9
	b.eq	LBB36_113
; %bb.112:
Lloh762:
	adrp	x8, __fzl_0@PAGE+12
Lloh763:
	ldr	w19, [x8, __fzl_0@PAGEOFF+12]
	cmn	w19, #1
	b.ne	LBB36_114
LBB36_113:
Lloh764:
	adrp	x0, __fzl_0@PAGE+25
Lloh765:
	add	x0, x0, __fzl_0@PAGEOFF+25
	bl	_strlen
	mov	x19, x0
LBB36_114:
Lloh766:
	adrp	x20, ___stdoutp@GOTPAGE
Lloh767:
	ldr	x20, [x20, ___stdoutp@GOTPAGEOFF]
	ldr	x0, [x20]
	bl	_flockfile
	ldr	x3, [x20]
Lloh768:
	adrp	x0, __fzl_0@PAGE+25
Lloh769:
	add	x0, x0, __fzl_0@PAGEOFF+25
	mov	w1, #1                          ; =0x1
	mov	x2, x19
	bl	_fwrite
	cbz	x19, LBB36_116
; %bb.115:
Lloh770:
	adrp	x8, __fzl_0@PAGE
Lloh771:
	add	x8, x8, __fzl_0@PAGEOFF
	add	x8, x8, x19
	ldrb	w8, [x8, #24]
	cmp	w8, #10
	b.eq	LBB36_119
LBB36_116:
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.le	LBB36_118
; %bb.117:
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	mov	w9, #10                         ; =0xa
	strb	w9, [x8]
	b	LBB36_119
LBB36_118:
	mov	w0, #10                         ; =0xa
	bl	___swbuf
LBB36_119:
	ldr	x0, [x20]
	bl	_funlockfile
	bl	_sp_get_ARGV
	cbz	x0, LBB36_123
; %bb.120:
	ldr	x8, [x0, #8]
	cmp	x8, #1
	b.lt	LBB36_122
; %bb.121:
	ldr	x8, [x0]
	ldr	x0, [x8]
	b	LBB36_123
LBB36_122:
	mov	x0, #0                          ; =0x0
LBB36_123:
Lloh772:
	adrp	x1, __fzl_1@PAGE+25
Lloh773:
	add	x1, x1, __fzl_1@PAGEOFF+25
	bl	_sp_str_eq
	cbz	w0, LBB36_135
; %bb.124:
	mov	x21, #0                         ; =0x0
	mov	w22, #10                        ; =0xa
	b	LBB36_127
LBB36_125:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	strb	w22, [x8]
LBB36_126:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x0, [x20]
	bl	_funlockfile
	add	x21, x21, #1
	cmp	x25, x21
	b.eq	LBB36_135
LBB36_127:                              ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #40]
	cbz	x8, LBB36_130
; %bb.128:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x9, [x8, #8]
	cmp	x21, x9
	b.ge	LBB36_130
; %bb.129:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x8, [x8]
	ldr	d0, [x8, x21, lsl #3]
	b	LBB36_131
	.p2align	6
LBB36_130:                              ;   in Loop: Header=BB36_127 Depth=1
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_131:                              ;   in Loop: Header=BB36_127 Depth=1
	bl	_sp_float_opt_to_s
	mov	x19, x0
	ldr	x0, [x20]
	bl	_flockfile
	cbz	x19, LBB36_133
; %bb.132:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x1, [x20]
	mov	x0, x19
	bl	_fputs
LBB36_133:                              ;   in Loop: Header=BB36_127 Depth=1
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.gt	LBB36_125
; %bb.134:                              ;   in Loop: Header=BB36_127 Depth=1
	mov	w0, #10                         ; =0xa
	bl	___swbuf
	b	LBB36_126
LBB36_135:
	bl	_sp_fin_run_exit
	ldr	w8, [sp, #32]                   ; 4-byte Folded Reload
	str	w8, [x24]
	ldp	x29, x30, [sp, #272]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #256]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #240]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #224]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #208]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #192]            ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #176]              ; 16-byte Folded Reload
	add	sp, sp, #288
	ret
LBB36_136:
	bl	__sp_main_body.cold.2
LBB36_137:
	bl	__sp_main_body.cold.1
LBB36_138:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_96
LBB36_139:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_107
LBB36_140:
	mov	x0, x19
	bl	_sp_raise_frozen_array_at
	.loh AdrpLdrGot	Lloh590, Lloh591
	.loh AdrpAdd	Lloh588, Lloh589
	.loh AdrpLdrGot	Lloh586, Lloh587
	.loh AdrpLdrGotLdr	Lloh592, Lloh593, Lloh594
	.loh AdrpAdd	Lloh657, Lloh658
	.loh AdrpLdrGot	Lloh655, Lloh656
	.loh AdrpAdd	Lloh653, Lloh654
	.loh AdrpLdrGot	Lloh651, Lloh652
	.loh AdrpAdd	Lloh649, Lloh650
	.loh AdrpLdrGot	Lloh647, Lloh648
	.loh AdrpAdd	Lloh645, Lloh646
	.loh AdrpLdrGot	Lloh643, Lloh644
	.loh AdrpAdd	Lloh641, Lloh642
	.loh AdrpLdrGot	Lloh639, Lloh640
	.loh AdrpAdd	Lloh637, Lloh638
	.loh AdrpAdd	Lloh635, Lloh636
	.loh AdrpAdd	Lloh633, Lloh634
	.loh AdrpLdrGot	Lloh631, Lloh632
	.loh AdrpAdd	Lloh629, Lloh630
	.loh AdrpLdrGot	Lloh627, Lloh628
	.loh AdrpAdd	Lloh625, Lloh626
	.loh AdrpLdrGot	Lloh623, Lloh624
	.loh AdrpAdd	Lloh621, Lloh622
	.loh AdrpAdd	Lloh619, Lloh620
	.loh AdrpAdd	Lloh617, Lloh618
	.loh AdrpLdrGot	Lloh615, Lloh616
	.loh AdrpAdd	Lloh613, Lloh614
	.loh AdrpAdd	Lloh611, Lloh612
	.loh AdrpAdd	Lloh609, Lloh610
	.loh AdrpAdd	Lloh607, Lloh608
	.loh AdrpAdd	Lloh605, Lloh606
	.loh AdrpAdd	Lloh603, Lloh604
	.loh AdrpAdd	Lloh601, Lloh602
	.loh AdrpAdd	Lloh599, Lloh600
	.loh AdrpAdd	Lloh597, Lloh598
	.loh AdrpAdd	Lloh595, Lloh596
	.loh AdrpLdr	Lloh714, Lloh715
	.loh AdrpLdrGot	Lloh712, Lloh713
	.loh AdrpLdr	Lloh710, Lloh711
	.loh AdrpAdd	Lloh707, Lloh708
	.loh AdrpLdrGotStr	Lloh705, Lloh706, Lloh709
	.loh AdrpAdd	Lloh701, Lloh702
	.loh AdrpLdrGotStr	Lloh699, Lloh700, Lloh704
	.loh AdrpAdd	Lloh697, Lloh698
	.loh AdrpLdrGotStr	Lloh695, Lloh696, Lloh703
	.loh AdrpAdd	Lloh692, Lloh693
	.loh AdrpLdrGotStr	Lloh689, Lloh690, Lloh694
	.loh AdrpAdd	Lloh687, Lloh688
	.loh AdrpLdrGotStr	Lloh685, Lloh686, Lloh691
	.loh AdrpAdd	Lloh682, Lloh683
	.loh AdrpLdrGotStr	Lloh680, Lloh681, Lloh684
	.loh AdrpAdrp	Lloh679, Lloh682
	.loh AdrpAdd	Lloh677, Lloh678
	.loh AdrpAdd	Lloh674, Lloh675
	.loh AdrpLdrGotStr	Lloh672, Lloh673, Lloh676
	.loh AdrpAdrp	Lloh671, Lloh674
	.loh AdrpAdd	Lloh669, Lloh670
	.loh AdrpAdd	Lloh666, Lloh667
	.loh AdrpLdrGotStr	Lloh664, Lloh665, Lloh668
	.loh AdrpAdd	Lloh661, Lloh662
	.loh AdrpLdrGotStr	Lloh659, Lloh660, Lloh663
	.loh AdrpLdrGot	Lloh720, Lloh721
	.loh AdrpLdrGot	Lloh718, Lloh719
	.loh AdrpLdrGot	Lloh716, Lloh717
	.loh AdrpLdrGotLdr	Lloh722, Lloh723, Lloh724
	.loh AdrpLdrGotLdr	Lloh728, Lloh729, Lloh730
	.loh AdrpLdrGotLdr	Lloh725, Lloh726, Lloh727
	.loh AdrpLdrGotLdr	Lloh731, Lloh732, Lloh733
	.loh AdrpLdrGotLdr	Lloh734, Lloh735, Lloh736
	.loh AdrpAdd	Lloh737, Lloh738
	.loh AdrpLdrGotStr	Lloh745, Lloh746, Lloh747
	.loh AdrpLdrGotStr	Lloh742, Lloh743, Lloh744
	.loh AdrpLdrGotStr	Lloh739, Lloh740, Lloh741
	.loh AdrpLdrGot	Lloh748, Lloh749
	.loh AdrpLdrGot	Lloh750, Lloh751
	.loh AdrpAdd	Lloh752, Lloh753
	.loh AdrpLdrGot	Lloh754, Lloh755
	.loh AdrpLdrGot	Lloh756, Lloh757
	.loh AdrpAdd	Lloh758, Lloh759
	.loh AdrpAdd	Lloh760, Lloh761
	.loh AdrpLdr	Lloh762, Lloh763
	.loh AdrpAdd	Lloh764, Lloh765
	.loh AdrpAdd	Lloh768, Lloh769
	.loh AdrpLdrGot	Lloh766, Lloh767
	.loh AdrpAdd	Lloh770, Lloh771
	.loh AdrpAdd	Lloh772, Lloh773

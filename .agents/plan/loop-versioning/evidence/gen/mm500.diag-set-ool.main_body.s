__sp_main_body:                         ; @_sp_main_body
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #272
	stp	d9, d8, [sp, #160]              ; 16-byte Folded Spill
	stp	x28, x27, [sp, #176]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #192]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #208]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #224]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #240]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #256]            ; 16-byte Folded Spill
	add	x29, sp, #256
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
	stp	q0, q1, [sp, #48]
	add	x8, sp, #48
	orr	x0, x8, #0x3
Lloh600:
	adrp	x11, _sp_gc_roots@GOTPAGE
Lloh601:
	ldr	x11, [x11, _sp_gc_roots@GOTPAGEOFF]
	cmp	w10, #16, lsl #12               ; =65536
	str	w10, [sp, #16]                  ; 4-byte Folded Spill
	b.ge	LBB36_2
; %bb.1:
	add	w8, w10, #1
	str	w8, [x9]
	str	x0, [x11, w10, sxtw #3]
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
	adrp	x1, l_.str.199@PAGE
Lloh608:
	add	x1, x1, l_.str.199@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh609:
	adrp	x0, _sp_StrArray_scan@PAGE
Lloh610:
	add	x0, x0, _sp_StrArray_scan@PAGEOFF
Lloh611:
	adrp	x1, l_.str.200@PAGE
Lloh612:
	add	x1, x1, l_.str.200@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh613:
	adrp	x0, _sp_SymPolyHash_scan@PAGE
Lloh614:
	add	x0, x0, _sp_SymPolyHash_scan@PAGEOFF
Lloh615:
	adrp	x1, l_.str.201@PAGE
Lloh616:
	add	x1, x1, l_.str.201@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh617:
	adrp	x0, _sp_StrPolyHash_scan@PAGE
Lloh618:
	add	x0, x0, _sp_StrPolyHash_scan@PAGEOFF
Lloh619:
	adrp	x1, l_.str.202@PAGE
Lloh620:
	add	x1, x1, l_.str.202@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh621:
	adrp	x0, _sp_PolyPolyHash_scan@PAGE
Lloh622:
	add	x0, x0, _sp_PolyPolyHash_scan@PAGEOFF
Lloh623:
	adrp	x1, l_.str.203@PAGE
Lloh624:
	add	x1, x1, l_.str.203@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh625:
	adrp	x0, _sp_Enumerator_scan@GOTPAGE
Lloh626:
	ldr	x0, [x0, _sp_Enumerator_scan@GOTPAGEOFF]
Lloh627:
	adrp	x1, l_.str.204@PAGE
Lloh628:
	add	x1, x1, l_.str.204@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh629:
	adrp	x0, _sp_OpenStruct_scan@PAGE
Lloh630:
	add	x0, x0, _sp_OpenStruct_scan@PAGEOFF
Lloh631:
	adrp	x1, l_.str.205@PAGE
Lloh632:
	add	x1, x1, l_.str.205@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh633:
	adrp	x0, _sp_Dir_scan@GOTPAGE
Lloh634:
	ldr	x0, [x0, _sp_Dir_scan@GOTPAGEOFF]
Lloh635:
	adrp	x1, l_.str.206@PAGE
Lloh636:
	add	x1, x1, l_.str.206@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh637:
	adrp	x0, _sp_Proc_scan@GOTPAGE
Lloh638:
	ldr	x0, [x0, _sp_Proc_scan@GOTPAGEOFF]
Lloh639:
	adrp	x1, l_.str.207@PAGE
Lloh640:
	add	x1, x1, l_.str.207@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh641:
	adrp	x0, _sp_exc_gc_scan@GOTPAGE
Lloh642:
	ldr	x0, [x0, _sp_exc_gc_scan@GOTPAGEOFF]
Lloh643:
	adrp	x1, l_.str.208@PAGE
Lloh644:
	add	x1, x1, l_.str.208@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh645:
	adrp	x0, _sp_PtrArray_gc_scan@PAGE
Lloh646:
	add	x0, x0, _sp_PtrArray_gc_scan@PAGEOFF
Lloh647:
	adrp	x1, l_.str.209@PAGE
Lloh648:
	add	x1, x1, l_.str.209@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh649:
	adrp	x0, _sp_StrIntHash_scan@GOTPAGE
Lloh650:
	ldr	x0, [x0, _sp_StrIntHash_scan@GOTPAGEOFF]
Lloh651:
	adrp	x1, l_.str.210@PAGE
Lloh652:
	add	x1, x1, l_.str.210@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh653:
	adrp	x0, _sp_StrStrHash_scan@GOTPAGE
Lloh654:
	ldr	x0, [x0, _sp_StrStrHash_scan@GOTPAGEOFF]
Lloh655:
	adrp	x1, l_.str.211@PAGE
Lloh656:
	add	x1, x1, l_.str.211@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh657:
	adrp	x0, _sp_IntStrHash_scan@GOTPAGE
Lloh658:
	ldr	x0, [x0, _sp_IntStrHash_scan@GOTPAGEOFF]
Lloh659:
	adrp	x1, l_.str.212@PAGE
Lloh660:
	add	x1, x1, l_.str.212@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh661:
	adrp	x0, _sp_curry_scan@GOTPAGE
Lloh662:
	ldr	x0, [x0, _sp_curry_scan@GOTPAGEOFF]
Lloh663:
	adrp	x1, l_.str.213@PAGE
Lloh664:
	add	x1, x1, l_.str.213@PAGEOFF
	bl	_sp_alloc_report_tag
Lloh665:
	adrp	x0, _sp_BoundMethod_scan@GOTPAGE
Lloh666:
	ldr	x0, [x0, _sp_BoundMethod_scan@GOTPAGEOFF]
Lloh667:
	adrp	x1, l_.str.214@PAGE
Lloh668:
	add	x1, x1, l_.str.214@PAGEOFF
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
	mov	x27, #0                         ; =0x0
	ubfiz	x28, x19, #3, #32
	add	x26, x20, #8
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
	str	x22, [x0, x27]
	add	x27, x27, #8
	cmp	x28, x27
	b.eq	LBB36_22
LBB36_9:                                ; =>This Inner Loop Header: Depth=1
	ldr	x20, [x26, x27]
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
	adrp	x0, l_.str.46@PAGE
Lloh748:
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
	stp	xzr, xzr, [sp, #32]
	add	x8, sp, #40
	add	x9, sp, #32
	stp	x8, x9, [sp, #56]
	str	xzr, [sp, #24]
	add	x8, sp, #24
	str	x8, [sp, #72]
	bl	_sp_matgen
	str	x0, [sp, #40]
	bl	_sp_matgen
	str	x0, [sp, #32]
	ldr	x8, [sp, #40]
	stp	x0, x8, [x29, #-120]
Lloh758:
	adrp	x9, _sp_gc_nroots@GOTPAGE
Lloh759:
	ldr	x9, [x9, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w10, [x9]
	movi.2d	v0, #0000000000000000
	str	xzr, [sp, #128]
	stp	q0, q0, [sp, #96]
	mov	w8, #4                          ; =0x4
	str	w8, [sp, #100]
	add	x8, sp, #96
	orr	x0, x8, #0x3
	cmp	w10, #16, lsl #12               ; =65536
	str	w10, [sp, #20]                  ; 4-byte Folded Spill
	b.ge	LBB36_24
; %bb.23:
	add	w8, w10, #1
	str	w8, [x9]
Lloh760:
	adrp	x8, _sp_gc_roots@GOTPAGE
Lloh761:
	ldr	x8, [x8, _sp_gc_roots@GOTPAGEOFF]
	str	x0, [x8, w10, sxtw #3]
	b	LBB36_25
LBB36_24:
	bl	_sp_gc_root_push_slow
LBB36_25:
	mov	w20, #53392                     ; =0xd090
	movk	w20, #3, lsl #16
	sub	x8, x29, #112
	sub	x9, x29, #120
	stp	x8, x9, [sp, #104]
	str	xzr, [sp, #88]
	add	x8, sp, #88
	str	x8, [sp, #120]
Lloh762:
	adrp	x1, _sp_FloatArray_fin@PAGE
Lloh763:
	add	x1, x1, _sp_FloatArray_fin@PAGEOFF
	mov	w0, #40                         ; =0x28
	mov	x2, #0                          ; =0x0
	bl	_sp_gc_alloc
	mov	x19, x0
	str	x20, [x0, #16]
	mov	w0, #33920                      ; =0x8480
	movk	w0, #30, lsl #16
	bl	_sp_slab_alloc_raw
	str	x0, [x19]
	cbnz	x0, LBB36_27
; %bb.26:
	bl	_sp_oom_die
	ldr	x0, [x19]
LBB36_27:
	mov	x22, #1                         ; =0x1
	movk	x22, #32760, lsl #48
	mov	w1, #33920                      ; =0x8480
	movk	w1, #30, lsl #16
	bl	_bzero
	mov	x26, #0                         ; =0x0
	mov	x17, #0                         ; =0x0
	ldr	x8, [x19, #16]
	lsl	x8, x8, #3
	ldur	x9, [x19, #-24]
	add	x9, x9, x8
	stur	x9, [x19, #-24]
Lloh764:
	adrp	x9, _sp_gc_bytes@GOTPAGE
Lloh765:
	ldr	x9, [x9, _sp_gc_bytes@GOTPAGEOFF]
	ldr	x10, [x9]
	add	x8, x10, x8
	str	x20, [x19, #8]
	str	x8, [x9]
	stp	x19, x19, [sp, #80]
	add	x8, sp, #80
	str	x8, [sp, #128]
	mov	w1, #500                        ; =0x1f4
	mov	x0, x19
LBB36_28:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB36_30 Depth 2
                                        ;       Child Loop BB36_39 Depth 3
	mov	x23, #0                         ; =0x0
	mov	x21, #0                         ; =0x0
	mul	x25, x17, x1
	b	LBB36_30
	.p2align	6
LBB36_29:                               ;   in Loop: Header=BB36_30 Depth=2
	add	x21, x21, #1
	add	x23, x23, #500
	cmp	x21, #500
	b.eq	LBB36_66
LBB36_30:                               ;   Parent Loop BB36_28 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB36_39 Depth 3
	ldur	x8, [x29, #-112]
	cbz	x8, LBB36_35
; %bb.31:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	x10, [x8, #8]
	add	x9, x21, x25
	cmp	x9, x10
	b.ge	LBB36_35
; %bb.32:                               ;   in Loop: Header=BB36_30 Depth=2
	ldr	x8, [x8]
	ldr	d8, [x8, x9, lsl #3]
	cbnz	x19, LBB36_36
LBB36_33:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x9, #0                          ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w10, #0                         ; =0x0
	ldur	x11, [x29, #-120]
	cbnz	x11, LBB36_37
LBB36_34:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x12, #0                         ; =0x0
	mov	x13, #0                         ; =0x0
	b	LBB36_38
	.p2align	6
LBB36_35:                               ;   in Loop: Header=BB36_30 Depth=2
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d8, x8
	cbz	x19, LBB36_33
LBB36_36:                               ;   in Loop: Header=BB36_30 Depth=2
	ldp	x8, x9, [x19]
	ldr	x10, [x19, #24]
	cmp	x10, #0
	cset	w10, eq
	ldur	x11, [x29, #-120]
	cbz	x11, LBB36_34
LBB36_37:                               ;   in Loop: Header=BB36_30 Depth=2
	ldp	x12, x13, [x11]
LBB36_38:                               ;   in Loop: Header=BB36_30 Depth=2
	fmov	x28, d8
	mov	x20, x26
	mov	x24, x23
	mov	w27, #500                       ; =0x1f4
	mov	x14, x19
	.p2align	6
LBB36_39:                               ;   Parent Loop BB36_28 Depth=1
                                        ;     Parent Loop BB36_30 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x15, x8
	cmp	x20, x9
	b.lo	LBB36_43
; %bb.40:                               ;   in Loop: Header=BB36_39 Depth=3
	cbz	x0, LBB36_44
; %bb.41:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	x14, [x0, #8]
	cmp	x20, x14
	b.ge	LBB36_45
; %bb.42:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	x15, [x0]
	mov	x19, x0
	mov	x14, x0
LBB36_43:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	d0, [x15, x20, lsl #3]
	b	LBB36_46
LBB36_44:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x19, #0                         ; =0x0
	mov	x14, #0                         ; =0x0
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d0, x15
	b	LBB36_46
LBB36_45:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x14, #1                         ; =0x1
	movk	x14, #32760, lsl #48
	fmov	d0, x14
	mov	x19, x0
	mov	x14, x0
	.p2align	6
LBB36_46:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x15, x12
	cmp	x24, x13
	b.lo	LBB36_50
; %bb.47:                               ;   in Loop: Header=BB36_39 Depth=3
	cbz	x11, LBB36_51
; %bb.48:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	x15, [x11, #8]
	cmp	x24, x15
	b.ge	LBB36_51
; %bb.49:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	x15, [x11]
LBB36_50:                               ;   in Loop: Header=BB36_39 Depth=3
	ldr	d1, [x15, x24, lsl #3]
	cmp	x28, x22
	b.ne	LBB36_52
	b	LBB36_70
	.p2align	6
LBB36_51:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x15, #1                         ; =0x1
	movk	x15, #32760, lsl #48
	fmov	d1, x15
	cmp	x28, x22
	b.eq	LBB36_70
LBB36_52:                               ;   in Loop: Header=BB36_39 Depth=3
	fmov	x15, d1
	cmp	x15, x22
	b.eq	LBB36_70
; %bb.53:                               ;   in Loop: Header=BB36_39 Depth=3
	fmov	x15, d0
	cmp	x15, x22
	b.eq	LBB36_71
; %bb.54:                               ;   in Loop: Header=BB36_39 Depth=3
	fmul	d1, d8, d1
	fmov	x16, d1
	cmp	x16, x22
	b.eq	LBB36_71
; %bb.55:                               ;   in Loop: Header=BB36_39 Depth=3
	fadd	d0, d0, d1
	cmp	x20, x9
	b.hs	LBB36_59
; %bb.56:                               ;   in Loop: Header=BB36_39 Depth=3
	cbz	w10, LBB36_59
; %bb.57:                               ;   in Loop: Header=BB36_39 Depth=3
	str	d0, [x8, x20, lsl #3]
	mov	w10, #1                         ; =0x1
LBB36_58:                               ;   in Loop: Header=BB36_39 Depth=3
	add	x24, x24, #1
	add	x20, x20, #1
	subs	x27, x27, #1
	b.ne	LBB36_39
	b	LBB36_29
LBB36_59:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x19, x17
	mov	x1, x20
	bl	_lv_set_ool
	ldr	x0, [sp, #88]
	cbz	x0, LBB36_61
; %bb.60:                               ;   in Loop: Header=BB36_39 Depth=3
	ldp	x8, x9, [x0]
	ldr	x10, [x0, #24]
	cmp	x10, #0
	cset	w10, eq
	b	LBB36_62
LBB36_61:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x9, #0                          ; =0x0
	mov	x8, #0                          ; =0x0
	mov	w10, #0                         ; =0x0
LBB36_62:                               ;   in Loop: Header=BB36_39 Depth=3
	ldur	x11, [x29, #-120]
	mov	x17, x19
	mov	w1, #500                        ; =0x1f4
	cbz	x11, LBB36_64
; %bb.63:                               ;   in Loop: Header=BB36_39 Depth=3
	ldp	x12, x13, [x11]
	b	LBB36_65
LBB36_64:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x13, #0                         ; =0x0
	mov	x12, #0                         ; =0x0
LBB36_65:                               ;   in Loop: Header=BB36_39 Depth=3
	mov	x19, x0
	mov	x14, x0
	b	LBB36_58
	.p2align	6
LBB36_66:                               ;   in Loop: Header=BB36_28 Depth=1
	add	x17, x17, #1
	add	x26, x26, #500
	cmp	x17, #500
	b.ne	LBB36_28
; %bb.67:
Lloh766:
	adrp	x23, _sp_gc_nroots@GOTPAGE
Lloh767:
	ldr	x23, [x23, _sp_gc_nroots@GOTPAGEOFF]
	ldr	w8, [sp, #20]                   ; 4-byte Folded Reload
	str	w8, [x23]
	str	x14, [sp, #24]
	cbz	x14, LBB36_72
; %bb.68:
	ldr	x8, [x14, #8]
	cmp	x8, #1
	b.lt	LBB36_72
; %bb.69:
	ldr	x8, [x14]
	ldr	d0, [x8]
	b	LBB36_73
LBB36_70:
	cmp	x28, x22
	cset	w0, eq
	bl	__sp_main_body.cold.4
LBB36_71:
	cmp	x15, x22
	cset	w0, eq
	bl	__sp_main_body.cold.3
LBB36_72:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_73:
	fmov	x8, d0
	cmp	x8, x22
	b.eq	LBB36_117
; %bb.74:
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d0, d0, d1
	mov	x8, #-4332462841530417152       ; =0xc3e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	mov	w24, #53392                     ; =0xd090
	movk	w24, #3, lsl #16
	b.lt	LBB36_119
; %bb.75:
	mov	x8, #4890909195324358656        ; =0x43e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.pl	LBB36_119
; %bb.76:
	fcvtzs	x0, d0
LBB36_77:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_79
; %bb.78:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	b	LBB36_80
LBB36_79:
	str	x0, [sp]
Lloh768:
	adrp	x0, l_.str.19@PAGE
Lloh769:
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_printf
LBB36_80:
	ldr	x8, [sp, #24]
	cbz	x8, LBB36_83
; %bb.81:
	ldr	x9, [x8, #8]
	sub	x10, x24, #1
	cmp	x9, x10
	b.le	LBB36_83
; %bb.82:
	ldr	x8, [x8]
	add	x9, x8, #488, lsl #12           ; =1998848
	ldr	d0, [x9, #1144]
	b	LBB36_84
LBB36_83:
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_84:
	fmov	x8, d0
	cmp	x8, x22
	b.eq	LBB36_118
; %bb.85:
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d0, d0, d1
	mov	x8, #-4332462841530417152       ; =0xc3e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.lt	LBB36_120
; %bb.86:
	mov	x8, #4890909195324358656        ; =0x43e0000000000000
	fmov	d1, x8
	fcmp	d0, d1
	b.pl	LBB36_120
; %bb.87:
	fcvtzs	x0, d0
LBB36_88:
	mov	x8, #-9223372036854775808       ; =0x8000000000000000
	cmp	x0, x8
	b.ne	LBB36_90
; %bb.89:
	mov	w0, #10                         ; =0xa
	bl	_putchar
	b	LBB36_91
LBB36_90:
	str	x0, [sp]
Lloh770:
	adrp	x0, l_.str.19@PAGE
Lloh771:
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_printf
LBB36_91:
	adrp	x8, __fzl_0@PAGE+24
	ldrb	w8, [x8, __fzl_0@PAGEOFF+24]
	sub	w8, w8, #241
	cmp	w8, #13
	b.hi	LBB36_94
; %bb.92:
	mov	w9, #1                          ; =0x1
	lsl	w8, w9, w8
	mov	w9, #16001                      ; =0x3e81
	tst	w8, w9
	b.eq	LBB36_94
; %bb.93:
Lloh772:
	adrp	x8, __fzl_0@PAGE+12
Lloh773:
	ldr	w19, [x8, __fzl_0@PAGEOFF+12]
	cmn	w19, #1
	b.ne	LBB36_95
LBB36_94:
Lloh774:
	adrp	x0, __fzl_0@PAGE+25
Lloh775:
	add	x0, x0, __fzl_0@PAGEOFF+25
	bl	_strlen
	mov	x19, x0
LBB36_95:
Lloh776:
	adrp	x20, ___stdoutp@GOTPAGE
Lloh777:
	ldr	x20, [x20, ___stdoutp@GOTPAGEOFF]
	ldr	x0, [x20]
	bl	_flockfile
	ldr	x3, [x20]
Lloh778:
	adrp	x0, __fzl_0@PAGE+25
Lloh779:
	add	x0, x0, __fzl_0@PAGEOFF+25
	mov	w1, #1                          ; =0x1
	mov	x2, x19
	bl	_fwrite
	cbz	x19, LBB36_97
; %bb.96:
Lloh780:
	adrp	x8, __fzl_0@PAGE
Lloh781:
	add	x8, x8, __fzl_0@PAGEOFF
	add	x8, x8, x19
	ldrb	w8, [x8, #24]
	cmp	w8, #10
	b.eq	LBB36_100
LBB36_97:
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.le	LBB36_99
; %bb.98:
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	mov	w9, #10                         ; =0xa
	strb	w9, [x8]
	b	LBB36_100
LBB36_99:
	mov	w0, #10                         ; =0xa
	bl	___swbuf
LBB36_100:
	ldr	x0, [x20]
	bl	_funlockfile
	bl	_sp_get_ARGV
	cbz	x0, LBB36_104
; %bb.101:
	ldr	x8, [x0, #8]
	cmp	x8, #1
	b.lt	LBB36_103
; %bb.102:
	ldr	x8, [x0]
	ldr	x0, [x8]
	b	LBB36_104
LBB36_103:
	mov	x0, #0                          ; =0x0
LBB36_104:
Lloh782:
	adrp	x1, __fzl_1@PAGE+25
Lloh783:
	add	x1, x1, __fzl_1@PAGEOFF+25
	bl	_sp_str_eq
	cbz	w0, LBB36_116
; %bb.105:
	mov	x21, #0                         ; =0x0
	mov	w22, #10                        ; =0xa
	b	LBB36_108
LBB36_106:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x8, [x1]
	add	x9, x8, #1
	str	x9, [x1]
	strb	w22, [x8]
LBB36_107:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x0, [x20]
	bl	_funlockfile
	add	x21, x21, #1
	cmp	x24, x21
	b.eq	LBB36_116
LBB36_108:                              ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]
	cbz	x8, LBB36_111
; %bb.109:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x9, [x8, #8]
	cmp	x21, x9
	b.ge	LBB36_111
; %bb.110:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x8, [x8]
	ldr	d0, [x8, x21, lsl #3]
	b	LBB36_112
	.p2align	6
LBB36_111:                              ;   in Loop: Header=BB36_108 Depth=1
	mov	x8, #1                          ; =0x1
	movk	x8, #32760, lsl #48
	fmov	d0, x8
LBB36_112:                              ;   in Loop: Header=BB36_108 Depth=1
	bl	_sp_float_opt_to_s
	mov	x19, x0
	ldr	x0, [x20]
	bl	_flockfile
	cbz	x19, LBB36_114
; %bb.113:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x1, [x20]
	mov	x0, x19
	bl	_fputs
LBB36_114:                              ;   in Loop: Header=BB36_108 Depth=1
	ldr	x1, [x20]
	ldr	w8, [x1, #12]
	sub	w9, w8, #1
	str	w9, [x1, #12]
	cmp	w8, #0
	b.gt	LBB36_106
; %bb.115:                              ;   in Loop: Header=BB36_108 Depth=1
	mov	w0, #10                         ; =0xa
	bl	___swbuf
	b	LBB36_107
LBB36_116:
	bl	_sp_fin_run_exit
	ldr	w8, [sp, #16]                   ; 4-byte Folded Reload
	str	w8, [x23]
	ldp	x29, x30, [sp, #256]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #240]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #224]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #208]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #192]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #176]            ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #160]              ; 16-byte Folded Reload
	add	sp, sp, #272
	ret
LBB36_117:
	bl	__sp_main_body.cold.2
LBB36_118:
	bl	__sp_main_body.cold.1
LBB36_119:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_77
LBB36_120:
	bl	_sp_float_to_i_checked_slow
	b	LBB36_88
	.loh AdrpLdrGot	Lloh600, Lloh601
	.loh AdrpAdd	Lloh598, Lloh599
	.loh AdrpLdrGot	Lloh596, Lloh597
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
	.loh AdrpLdrGot	Lloh758, Lloh759
	.loh AdrpLdrGot	Lloh760, Lloh761
	.loh AdrpAdd	Lloh762, Lloh763
	.loh AdrpLdrGot	Lloh764, Lloh765
	.loh AdrpLdrGot	Lloh766, Lloh767
	.loh AdrpAdd	Lloh768, Lloh769
	.loh AdrpAdd	Lloh770, Lloh771
	.loh AdrpLdr	Lloh772, Lloh773
	.loh AdrpAdd	Lloh774, Lloh775
	.loh AdrpAdd	Lloh778, Lloh779
	.loh AdrpLdrGot	Lloh776, Lloh777
	.loh AdrpAdd	Lloh780, Lloh781
	.loh AdrpAdd	Lloh782, Lloh783

; gen/mm500.versioned.c, @_sp_main_body, -O2 -fno-discard-value-names
; the runtime overlap check between c and b:
for.cond.preheader.i:                             ; preds = %land.lhs.true135.i
  %42 = getelementptr inbounds nuw double, ptr %cond694697.i, i64 %19
  %43 = getelementptr inbounds nuw double, ptr %cond88700.i, i64 %39
  %44 = getelementptr i8, ptr %cond694697.i, i64 %18
  %scevgep = getelementptr i8, ptr %44, i64 4000
  %45 = getelementptr i8, ptr %cond88700.i, i64 %24
  %scevgep367 = getelementptr i8, ptr %45, i64 4000
  %bound0 = icmp ult ptr %42, %scevgep367
  %bound1 = icmp ult ptr %43, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body.i.preheader, label %vector.ph


; the vectorized body:
vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %46 = getelementptr inbounds nuw double, ptr %42, i64 %index
  %47 = getelementptr inbounds nuw i8, ptr %46, i64 16
  %48 = getelementptr inbounds nuw i8, ptr %46, i64 32
  %49 = getelementptr inbounds nuw i8, ptr %46, i64 48
  %wide.load = load <2 x double>, ptr %46, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  %wide.load368 = load <2 x double>, ptr %47, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  %wide.load369 = load <2 x double>, ptr %48, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  %wide.load370 = load <2 x double>, ptr %49, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  %50 = getelementptr inbounds nuw double, ptr %43, i64 %index
  %51 = getelementptr inbounds nuw i8, ptr %50, i64 16
  %52 = getelementptr inbounds nuw i8, ptr %50, i64 32
  %53 = getelementptr inbounds nuw i8, ptr %50, i64 48
  %wide.load371 = load <2 x double>, ptr %50, align 8, !tbaa !53, !alias.scope !208
  %wide.load372 = load <2 x double>, ptr %51, align 8, !tbaa !53, !alias.scope !208
  %wide.load373 = load <2 x double>, ptr %52, align 8, !tbaa !53, !alias.scope !208
  %wide.load374 = load <2 x double>, ptr %53, align 8, !tbaa !53, !alias.scope !208
  %54 = fmul <2 x double> %broadcast.splat, %wide.load371
  %55 = fmul <2 x double> %broadcast.splat, %wide.load372
  %56 = fmul <2 x double> %broadcast.splat, %wide.load373
  %57 = fmul <2 x double> %broadcast.splat, %wide.load374
  %58 = fadd <2 x double> %wide.load, %54
  %59 = fadd <2 x double> %wide.load368, %55
  %60 = fadd <2 x double> %wide.load369, %56
  %61 = fadd <2 x double> %wide.load370, %57
  store <2 x double> %58, ptr %46, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  store <2 x double> %59, ptr %47, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  store <2 x double> %60, ptr %48, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  store <2 x double> %61, ptr %49, align 8, !tbaa !53, !alias.scope !205, !noalias !208
  %index.next = add nuw i64 %index, 8
  %62 = icmp eq i64 %index.next, 496
  br i1 %62, label %for.body.i.preheader, label %vector.body, !llvm.loop !210


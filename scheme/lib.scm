(begin
  (define (ld_b x)  
    (ld_b0 ($slc 0 x))
    (ld_b1 ($slc 1 x))
    (ld_b2 ($slc 2 x))
    (ld_b3 ($slc 3 x))
  )
  (define (ld_c x)
    (ld_c0 ($slc 0 x))
    (ld_c1 ($slc 1 x))
    (ld_c2 ($slc 2 x))
    (ld_c3 ($slc 3 x))
  )

  (define (bu x)
    (ld_b x)
    (bu_b)
  )
  (define (bz x)
    (ld_b x)
    (bz_b)
  )
  (define (bc x)
    (ld_b x)
    (bc_b)
  )

  (define (clc)
    (nor ($word 0))
    (nor ($word 0))
  )
  (define (ld_c_@x x)
    (ld_b x)
    (ld_c0_@b)
    (ld_b0 ($off 1 ($slc 0 x)))
    (ld_c1_@b)
    (ld_b0 ($off 2 ($slc 0 x)))
    (ld_c2_@b)
    (ld_b0 ($off 3 ($slc 0 x)))
    (ld_c3_@b)
  )
  (define (ld_b_@x x)
    (ld_c x)
    (ld_b0_@c)
    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_b1_@c)
    (ld_c0 ($off 2 ($slc 0 x)))
    (ld_b2_@c)
    (ld_c0 ($off 3 ($slc 0 x)))
    (ld_b3_@c)
  )

  (define (st_v_@x v x)
    (ld_c x)
    (ld_a v)
    (st_a_@c)
  )
  (define (st2_v_@x v x)
    (ld_c x)
    (ld_a ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a ($slc 1 v))
    (st_a_@c)
  )
  (define (st4_v_@x v x)
    (ld_c x)
    (ld_a ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a ($slc 1 v))
    (st_a_@c)

    (ld_c0 ($off 2 ($slc 0 x)))
    (ld_a ($slc 2 v))
    (st_a_@c)

    (ld_c0 ($off 3 ($slc 0 x)))
    (ld_a ($slc 3 v))
    (st_a_@c)
  )
  (define (st8_v_@x v x)
    (ld_c x)
    (ld_a ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a ($slc 1 v))
    (st_a_@c)

    (ld_c0 ($off 2 ($slc 0 x)))
    (ld_a ($slc 2 v))
    (st_a_@c)

    (ld_c0 ($off 3 ($slc 0 x)))
    (ld_a ($slc 3 v))
    (st_a_@c)

    (ld_c0 ($off 4 ($slc 0 x)))
    (ld_a ($slc 4 v))
    (st_a_@c)

    (ld_c0 ($off 5 ($slc 0 x)))
    (ld_a ($slc 5 v))
    (st_a_@c)

    (ld_c0 ($off 6 ($slc 0 x)))
    (ld_a ($slc 6 v))
    (st_a_@c)

    (ld_c0 ($off 7 ($slc 0 x)))
    (ld_a ($slc 7 v))
    (st_a_@c)
  )

  (define (add_@x_v x v)
    (clc)
    (ld_c x)
    (ld_a_@c)
    (add v)
    (st_a_@c)
  )
  (define (add2_@x_v x v)
    (clc)
    (ld_c x)
    (ld_a_@c)
    (add ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 1 v))
    (st_a_@c)
  )
  (define (add4_@x_v x v)
    (clc)
    (ld_c x)
    (ld_a_@c)
    (add ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 1 v))
    (st_a_@c)

    (ld_c0 ($off 2 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 2 v))
    (st_a_@c)

    (ld_c0 ($off 3 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 3 v))
    (st_a_@c)
  )
  (define (add8_@x_v x v)
    (clc)
    (ld_c x)
    (ld_a_@c)
    (add ($slc 0 v))
    (st_a_@c)

    (ld_c0 ($off 1 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 1 v))
    (st_a_@c)

    (ld_c0 ($off 2 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 2 v))
    (st_a_@c)

    (ld_c0 ($off 3 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 3 v))
    (st_a_@c)

    (ld_c0 ($off 4 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 4 v))
    (st_a_@c)

    (ld_c0 ($off 5 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 5 v))
    (st_a_@c)

    (ld_c0 ($off 6 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 6 v))
    (st_a_@c)

    (ld_c0 ($off 7 ($slc 0 x)))
    (ld_a_@c)
    (add ($slc 7 v))
    (st_a_@c)
  )
)


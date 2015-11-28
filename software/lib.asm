macro   bu x
        ld_b x
        bu_b
end

macro   bz x
        ld_b x
        bz_b
end

macro   bc x
        ld_b x
        bc_b
end

macro   ld_b x
        ld_b0 x/0
        ld_b1 x/1
        ld_b2 x/2
end

macro   ld_c x
        ld_c0 x/0
        ld_c1 x/1
        ld_c2 x/2
end

macro   cmp4 x v
        ld_c x
        ld_a_@c
        cmp v/0
        bz cmp1
        bu done
cmp1:   ld_c0 x/0+1
        ld_a_@c
        cmp v/1
        bz cmp2
        bu done
cmp2:   ld_c0 x/0+2
        ld_a_@c
        cmp v/2
        bz cmp3
        bu done
cmp3:   ld_c0 x/0+3
        ld_a_@c
        cmp v/3
done:   nop
end

macro   add4 x v
        ld_c x
        ld_a_@c
        add v/0
        st_a_@c

        ld_c0 x/0+1
        bc car1
        ld_a_@c
        add v/1
        st_a_@c
        bu add2
car1:   ld_a_@c
        cmp 0xf
        bz ecar1
        add 0x1
        add v/1
        st_a_@c
        bu add2
ecar1:  ld_a v/1
        st_a_@c
        ld_a 0xf
        add 0x1

add2:   ld_c0 x/0+2
        bc car2
        ld_a_@c
        add v/1
        st_a_@c
        bu add3
car2:   ld_a_@c
        cmp 0xf
        bz ecar2
        add 0x1
        add v/1
        st_a_@c
        bu add3
ecar2:  ld_a v/1
        st_a_@c
        ld_a 0xf
        add 0x1

add3:   ld_c0 x/0+3
        bc car3
        ld_a_@c
        add v/1
        st_a_@c
        bu done
car3:   ld_a_@c
        cmp 0xf
        bz ecar3
        add 0x1
        add v/1
        st_a_@c
        bu done
ecar3:  ld_a v/1
        st_a_@c
        ld_a 0xf
        add 0x1
done:   nop

        end

macro   st4 v x
        ld_c x
        ld_a v/0
        st_a_@c

        ld_c0 x/0+1
        ld_a v/1
        st_a_@c

        ld_c0 x/0+2
        ld_a v/2
        st_a_@c

        ld_c0 x/0+3
        ld_a v/3
        st_a_@c
end

macro   rst4 v x
        ld_b x
        ld_c0_@b

        ld_b0 x/0+1
        ld_c1_@b

        ld_b0 x/0+2
        ld_c2_@b

        ld_a v/0
        st_a_@c

        ld_b0 x/0
        ld_a_@b
        add 0x1
        ld_c0_a

        ld_a v/1
        st_a_@c

        ld_b0 x/0
        ld_a_@b
        add 0x2
        ld_c0_a

        ld_a v/2
        st_a_@c

        ld_b0 x/0
        ld_a_@b
        add 0x3
        ld_c0_a

        ld_a v/3
        st_a_@c
end

macro   rld4 y x
        ld_b x
        ld_c0_@b

        ld_b0 x/0+1
        ld_c1_@b

        ld_b0 x/0+2
        ld_c2_@b

        ld_a_@c
        ld_b y
        st_a_@b

        ld_b x
        ld_a_@b
        add 0x1
        ld_c0_a

        ld_a_@c
        ld_b y
        ld_b0 y/0+1
        st_a_@b

        ld_b x
        ld_a_@b
        add 0x2
        ld_c0_a

        ld_a_@c
        ld_b y
        ld_b0 y/0+2
        st_a_@b

        ld_b x
        ld_a_@b
        add 0x3
        ld_c0_a

        ld_a_@c
        ld_b y
        ld_b0 y/0+3
        st_a_@b
end
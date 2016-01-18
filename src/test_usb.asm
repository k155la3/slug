macro   main

        usb_init
        keypad_init
        screen_init
        usb_write_char_v 0x0d
        usb_write_char_v 0x0a
        usb_write_char_v "o"
        usb_write_char_v "k"
        usb_write_char_v "."
        usb_write_char_v 0x0d
        usb_write_char_v 0x0a
wait:   usb_read_char
        is_read r_usb
        keypad_read_code 
        is_read r_key
        bu wait

r_key:  st_@x_@y keypad.code usb.char
        st_v_@x 0x3 usb.char+0x1

r_usb:  st2_@x_@y usb.char screen.char

        screen_char
        usb_write_char
        bu wait
end
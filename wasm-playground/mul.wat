(module
    (table 2 funcref)
    (elem (i32.const 0) $helloWorld $fact)

    (func $helloWorld (param $x i32) (result i32)
        (i32.const 42)
    )

    (export "helloWorld" (func $helloWorld))

    (func $mul (param $x i32) (param $y i32) (result i32)
        (i32.mul
            (get_local $x)
            (get_local $y)
        )
    )

    (func $fact (param $x i32) (result i32)
        (local $result i32)
        (set_local $result (i32.const 1))
        (block $end
            (loop $start
                (br_if $end ;; End condition
                    (i32.eq
                        (get_local $x)
                        (i32.const 0)
                    )
                )
                (set_local $result
                    (i32.mul
                        (get_local $result)
                        (get_local $x)
                    )
                )
                (set_local $x
                    (i32.sub
                        (get_local $x)
                        (i32.const 1)
                    )
                )
                (br $start)
            )
        )
        (get_local $result)
    )

    (func $fib (param $n i32) (result i32)
        (local $a i32)
        (local $b i32)
        (set_local $a (i32.const 1))
        (set_local $b (i32.const 1))

        (block $end
            (loop $start
                (
                    (br_if $end
                        (i32.eq
                            (get_local $n)
                            (i32.const 0)
                        )
                    )
                )
                
                (br $start)
            )
        )
    )

    (func $even (param $x i32) (result i32)
        (i32.const -1)
    )

    (type $return_i32 (func (param i32) (result i32))) ;; if this was f32, type checking would fail
    (func $apply (param $f i32) (param $x i32) (result i32)
        get_local $x
        get_local $f
        call_indirect (type $return_i32)
    )
    (export "apply" (func $apply))

    ;; $n is the number of functions to apply in sequence
    ;; $fs is an offset into memory. The first $n values at the *address* $fs are interpreted as
    ;;    function pointers into the global ftable
    ;; $x is the initial value
    (func $applys (param $n i32) (param $fs i32) (param $x i32) (result i32)
        (i32.const -1)
    )

    (func (export "mulTest1") (result i32)
        (call $mul
            (i32.const 4)
            (i32.const 3)
        )
    )

    (func (export "mulTest2") (result i32)
        (call $mul
            (i32.const 7)
            (i32.const 5)
        )
    )

    (func (export "factTest") (result i32)
        (call $fact
            (i32.const 5)
        )
    )

    (func (export "applyTest2") (result i32)
        (call $apply ;; Hello World (const 42)
            (i32.const 0)
            (i32.const 7)
        )
    )

    (func (export "applyTest") (result i32)
        (call $apply ;; Fact
            (i32.const 1)
            (i32.const 7)
        )
    )
)

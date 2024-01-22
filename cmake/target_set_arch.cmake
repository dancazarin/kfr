if (X86)

    function(target_set_arch TARGET MODE ARCH)

        set(ARCH_FLAGS_GNU_generic -DCMT_FORCE_GENERIC_CPU)
        set(ARCH_FLAGS_GNU_sse2    -msse2)
        set(ARCH_FLAGS_GNU_sse3    -msse3)
        set(ARCH_FLAGS_GNU_ssse3   -mssse3)
        set(ARCH_FLAGS_GNU_sse41   -msse4.1)
        set(ARCH_FLAGS_GNU_sse42   -msse4.2)
        set(ARCH_FLAGS_GNU_avx     -msse4.2 -mavx)
        set(ARCH_FLAGS_GNU_avx2    -msse4.2 -mavx2 -mfma)
        set(ARCH_FLAGS_GNU_avx512  -msse4.2 -mavx2 -mfma -mavx512f -mavx512cd -mavx512bw -mavx512dq -mavx512vl)

        if (BITNESS64)
            # SSE2 is part of x86_64
            set(ARCH_FLAG_MS_SSE2)
        else()
            set(ARCH_FLAG_MS_SSE2 -arch:SSE2)
        endif()

        set(ARCH_FLAGS_MS_generic  ${ARCH_FLAG_MS_SSE2} -DCMT_FORCE_GENERIC_CPU)
        set(ARCH_FLAGS_MS_sse2     ${ARCH_FLAG_MS_SSE2})
        set(ARCH_FLAGS_MS_sse3     ${ARCH_FLAG_MS_SSE2} -D__SSE3__)
        set(ARCH_FLAGS_MS_ssse3    ${ARCH_FLAG_MS_SSE2} -D__SSSE3__)
        set(ARCH_FLAGS_MS_sse41    ${ARCH_FLAG_MS_SSE2} -D__SSE3__ -D__SSSE3__ -D__SSE4_1__)
        set(ARCH_FLAGS_MS_sse42    ${ARCH_FLAG_MS_SSE2} -D__SSE3__ -D__SSSE3__ -D__SSE4_1__ -D__SSE4_2__)
        set(ARCH_FLAGS_MS_avx      -arch:AVX)
        set(ARCH_FLAGS_MS_avx2     -arch:AVX2)
        set(ARCH_FLAGS_MS_avx512   -arch:AVX512)

        if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
            set(CLANG 1)
        else ()
            set(CLANG 0)
        endif()
        if (CLANG OR NOT MSVC)
            # Reset previous arch flags
            if (BITNESS64)
                target_compile_options(${TARGET} ${MODE} -mno-sse3)
            else()
                target_compile_options(${TARGET} ${MODE} -mno-sse)
            endif()
        endif ()
        if (MSVC AND NOT CLANG)
            target_compile_options(${TARGET} ${MODE} ${ARCH_FLAGS_MS_${ARCH}})
        else()
            target_compile_options(${TARGET} ${MODE} ${ARCH_FLAGS_GNU_${ARCH}})
        endif ()
    endfunction()

else()

    function(target_set_arch TARGET MODE ARCH)
    endfunction()

endif ()

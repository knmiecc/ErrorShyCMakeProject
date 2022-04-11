#include "unity.h"

void test_mylib_init_initialisesAPassedDevicePointer(void) {
    TEST_ASSERT_EQUAL(1,1);
}

void test_mylib_init_shouldFail(void) {
    TEST_ASSERT_EQUAL(1,2);
}

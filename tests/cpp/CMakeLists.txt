# Test sources
set(TEST_SOURCES testFibo.cpp testArgs.cpp testPolymorph.cpp testVectorT.cpp)

# Generation folder
if (IS_MULTI_CONFIG)
  cmake_path(APPEND CMAKE_CURRENT_BINARY_DIR $<CONFIG>
             OUTPUT_VARIABLE TEST_DST_DIR)
else()
  cmake_path(APPEND CMAKE_CURRENT_BINARY_DIR ${CMAKE_BUILD_TYPE}
             OUTPUT_VARIABLE TEST_DST_DIR)
endif()
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${TEST_DST_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${TEST_DST_DIR})

# Define the prepare target to create the output directory for logs
if (WIN32)
  # Need to copy C++ shared library to tests directory
  if(MSYS)
    add_custom_target(prepare_cpp
      COMMAND ${CMAKE_COMMAND} -E make_directory "${TEST_DST_DIR}"
      COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${PROJECT_NAME}::shared> ${TEST_DST_DIR}
      # have both lib${PROJECT_NAME}.dll and ${PROJECT_NAME}.dll in ${TEST_DST_DIR}
      # this fixes a bug on MSYS when building R wrappers with shared
      # objects before linking C++ test binaries
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${TEST_DST_DIR}/lib${PROJECT_NAME}.dll ${TEST_DST_DIR}/${PROJECT_NAME}.dll
    )
  else()
    add_custom_target(prepare_cpp
      COMMAND ${CMAKE_COMMAND} -E make_directory "${TEST_DST_DIR}"
      COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${PROJECT_NAME}::shared> ${TEST_DST_DIR}
    )
  endif()
else()
  add_custom_target(prepare_cpp
    COMMAND ${CMAKE_COMMAND} -E make_directory "${TEST_DST_DIR}"
  )
endif()

# Compile each test executable
set(TARGETS_EXE "")
foreach(TEST_SOURCE_FILE ${TEST_SOURCES})
    # Retrieve source file name without extension (will become executable name)
    get_filename_component(TEST_NAME ${TEST_SOURCE_FILE} NAME_WE)
    # Add to executable targets list
    list(APPEND TARGETS_EXE ${TEST_NAME})
    # Define sources list for the target executable
    add_executable(${TEST_NAME} EXCLUDE_FROM_ALL ${TEST_SOURCE_FILE})
    # Link each test to shared library
    target_link_libraries(${TEST_NAME} PRIVATE ${PROJECT_NAME}::shared)
    # Trigger the prepare target each time a test is compiled
    add_dependencies(${TEST_NAME} prepare_cpp)
    # Trigger the build of the test with the target build_tests
    add_dependencies(build_tests ${TEST_NAME})
endforeach(TEST_SOURCE_FILE ${TEST_SOURCES})

# Display test output in case of failure
set(CTEST_OUTPUT_ON_FAILURE ON)

# Run each registered executable
foreach(TARGET_EXE ${TARGETS_EXE})
    # Run the test (and generate *.out in ${TEST_DST_DIR})
    add_test(NAME ${TARGET_EXE}
             COMMAND ${TARGET_EXE}
             WORKING_DIRECTORY ${TEST_DST_DIR})
    # Compare the output result (diff output is shown when CTEST_OUTPUT_ON_FAILURE=1)
    # Use git diff (cross-platform) with:
    # - no-index (no need to have files under git control)
    # - ignore lines starting with #NO_DIFF#
    # - ignore ALL whitespaces (https://stackoverflow.com/a/65462731)
    add_test(NAME ${TARGET_EXE}_cmp
             COMMAND git diff --no-index -I "#NO_DIFF#" --ignore-blank-lines --ignore-all-space --ignore-cr-at-eol ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_EXE}.ref ${TEST_DST_DIR}/${TARGET_EXE}.out)
endforeach(TARGET_EXE ${TARGETS_EXE})

# Create the check target to launch the tests
# Look parent CMakeLists for MY_CTEST_COMMAND definition
add_custom_target(check_cpp
  COMMAND ${MY_CTEST_COMMAND} DEPENDS ${TARGETS_EXE}
)

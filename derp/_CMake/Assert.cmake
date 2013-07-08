function( check_equal left right result )

	SET( result PARENT_SCOPE )

	LIST( LENGTH left left_length )
	LIST( LENGTH right right_length )

	#	Decrement the list lengths so we dont go out of bounds
	#		later in the FOREACH
	#

	MATH( EXPR left_length "${left_length} - 1" )
	MATH( EXPR right_length "${right_length} - 1" )

	if( left_length EQUAL right_length )

		if( left_length GREATER 1 )

			SET( list_elements_equal 1 )

			FOREACH( i RANGE ${left_length} )

				LIST( GET left ${i} temp_left )
				LIST( GET right ${i} temp_right )

				if( temp_left STREQUAL temp_right )
				else()
					MESSAGE( STATUS "${temp_left} != ${temp_right}" )
					SET( list_elements_equal 0 )
				endif()

			ENDFOREACH()

			if( ${list_elements_equal} EQUAL 1 )
				SET( ${result} 1 PARENT_SCOPE )
			else()
				SET( ${result} 0 PARENT_SCOPE )
			endif()

		else()

			if( left STREQUAL right )
				SET( ${result} 1 PARENT_SCOPE )
			else()
				SET( ${result} 0 PARENT_SCOPE )
			endif()

		endif()


	else()
		SET( ${result} 0 PARENT_SCOPE )
	endif()


endfunction( check_equal )


function( ASSERT_NOT_EQUAL lefty righty )

	check_equal( "${lefty}" "${righty}" derp )

	if( ${derp} EQUAL 1 )
		MESSAGE( FATAL_ERROR ">>> ${lefty} == ${righty}" )
	else()
		MESSAGE( STATUS ">>> ${lefty} != ${righty}" )
	endif()

endfunction( ASSERT_NOT_EQUAL )

function( ASSERT_EQUAL lefty righty )

	check_equal( "${lefty}" "${righty}" derp )

	if( ${derp} EQUAL 1 )
		MESSAGE( STATUS ">>> ${lefty} == ${righty}" )
	else()
		MESSAGE( FATAL_ERROR ">>> ${lefty} != ${righty}" )
	endif()

endfunction( ASSERT_EQUAL )

macro( run_assert_sanity_checks )

	#	Simple integers
	#

	#	Assert Null
	#

	ASSERT_EQUAL( "" "" )

	#	Assert Equal
	#

	ASSERT_EQUAL( 2 2 )

	#	Assert not equal
	#

	ASSERT_NOT_EQUAL( 3 5 )

	#	Lists
	#

	#	Assert Equal
	#

	SET( test_list_one 1 1 2 3 5 8 )
	SET( test_list_two 1 1 2 3 5 8 )

	LIST( LENGTH test_list_one test_list_one_length )
	LIST( LENGTH test_list_two test_list_two_length )

	ASSERT_EQUAL( "${test_list_one}" "${test_list_two}" )

	#	Assert Not Equal
	#

	SET( test_list_three 1 1 2 3 5 8 13 )

	ASSERT_NOT_EQUAL( "${test_list_one}" "${test_list_three}" )

	#	Assert lists containing two-digit numbers Equal
	#
	#	Notes:  Was not entirely sure on how list length
	#		was calculated.  This made me rest a bit
	#		easier.
	#	

	SET( test_list_four 1 1 2 3 5 8 13 )

	ASSERT_EQUAL( "${test_list_three}" "${test_list_four}" )

endmacro( run_assert_sanity_checks )

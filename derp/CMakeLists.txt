cmake_minimum_required( VERSION 2.8 )
project( Stuff )

include( ${CMAKE_SOURCE_DIR}/_CMake/Assert.cmake )

#run_assert_sanity_checks()

function( prime_factors number factor_list )

	#	Clear out the result variable
	#

	SET( factors PARENT_SCOPE )

	SET( candidate 2 )

	WHILE( number GREATER 1 )

		MATH( EXPR mod_result "${number} % ${candidate}" )

		WHILE( mod_result EQUAL 0 )
			LIST( APPEND temp_list ${candidate} )
			MATH( EXPR number "${number} / ${candidate}" )
			MATH( EXPR mod_result "${number} % ${candidate}" )
		ENDWHILE()

		MATH( EXPR candidate "${candidate} + 1" )
	ENDWHILE()

	#	IF( number GREATER 1 )
	#	LIST( APPEND temp_list ${number} )
	#	ENDIF()

	SET( ${factor_list} "${temp_list}" PARENT_SCOPE )

endfunction( prime_factors )

prime_factors( 1 factors )
ASSERT_EQUAL( "${factors}" "" )
MESSAGE( STATUS "1 Has Prime Factors Of: ${factors}" )

prime_factors( 2 factors )
ASSERT_EQUAL( "${factors}" "2" )
MESSAGE( STATUS "2 Has Prime Factors Of: ${factors}" )

prime_factors( 3 factors )
ASSERT_EQUAL( "${factors}" "3" )
MESSAGE( STATUS "3 Has Prime Factors Of: ${factors}" )

prime_factors( 4 factors )
ASSERT_EQUAL( "${factors}" "2;2" )
MESSAGE( STATUS "4 Has Prime Factors Of: ${factors}" )

prime_factors( 6 factors )
ASSERT_EQUAL( "${factors}" "2;3" )
MESSAGE( STATUS "6 Has Prime Factors Of: ${factors}" )

prime_factors( 8 factors )
ASSERT_EQUAL( "${factors}" "2;2;2" )
MESSAGE( STATUS "8 Has Prime Factors Of: ${factors}" )

prime_factors( 9 factors )
ASSERT_EQUAL( "${factors}" "3;3" )
MESSAGE( STATUS "9 Has Prime Factors Of: ${factors}" )

ASSERT_EQUAL( "test" "test" )



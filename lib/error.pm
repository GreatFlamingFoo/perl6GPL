
#extern int line_count; // the line number of current token

unit module Error

my Bool $m_runtime = False;
my Int $m_num_errors = 0;

sub error_header()
{
	if (m_runtime)
	{
		$*ERR.print( "Runtime error: " );
	}
	else 
	{
		$*ERR.print( "Semantic error on line ", $line_count, ": " );
	}
}

sub starting_execution() is export
{ $m_runtime = True; }

sub num_errors(--> Int) is export {return $m_num_errors;}
sub runtime(--> Bool) is export {return $m_runtime;}

enum Error_type <
	ANIMATION_PARAM_DOES_NOT_MATCH_FORWARD
	ANIMATION_PARAMETER_NAME_NOT_UNIQUE
	ARRAY_INDEX_MUST_BE_AN_INTEGER
	ARRAY_INDEX_OUT_OF_BOUNDS
	ASSIGNMENT_TYPE_ERROR
	ANIMATION_BLOCK_ASSIGNMENT_PARAMETER_TYPE_ERROR
	CANNOT_CHANGE_DERIVED_ATTRIBUTE
	EXIT_STATUS_MUST_BE_AN_INTEGER
	ILLEGAL_TOKEN
	INCORRECT_CONSTRUCTOR_PARAMETER_TYPE
	INVALID_ARRAY_SIZE
	INVALID_LHS_OF_ASSIGNMENT
	INVALID_LHS_OF_PLUS_ASSIGNMENT
	INVALID_LHS_OF_MINUS_ASSIGNMENT
	INVALID_LHS_OF_PLUS_PLUS
	INVALID_LHS_OF_MINUS_MINUS
	INVALID_RIGHT_OPERAND_TYPE
	INVALID_LEFT_OPERAND_TYPE
	INVALID_TYPE_FOR_INITIAL_VALUE
	INVALID_TYPE_FOR_FOR_STMT_EXPRESSION
	INVALID_TYPE_FOR_IF_STMT_EXPRESSION
	INVALID_TYPE_FOR_PRINT_STMT_EXPRESSION
	INVALID_TYPE_FOR_RESERVED_VARIABLE
	INVALID_ARGUMENT_FOR_RANDOM
	LHS_OF_PERIOD_MUST_BE_OBJECT
	MINUS_ASSIGNMENT_TYPE_ERROR
	NO_BODY_PROVIDED_FOR_FORWARD
	NO_FORWARD_FOR_ANIMATION_BLOCK
	OPERAND_MUST_BE_A_GAME_OBJECT
	PARSE_ERROR
	PLUS_ASSIGNMENT_TYPE_ERROR
	PREVIOUSLY_DECLARED_VARIABLE
	PREVIOUSLY_DEFINED_ANIMATION_BLOCK
	TYPE_MISMATCH_BETWEEN_ANIMATION_BLOCK_AND_OBJECT
	UNDECLARED_MEMBER
	UNDECLARED_VARIABLE
	UNKNOWN_CONSTRUCTOR_PARAMETER
	VARIABLE_NOT_AN_ARRAY
	VARIABLE_IS_AN_ARRAY
	DIVIDE_BY_ZERO_AT_PARSE_TIME
	MOD_BY_ZERO_AT_PARSE_TIME
	UNDEFINED_ERROR
>;

sub error(Error_type $type, String s1 = "", String s2 = "", String s3 = "")
		is export
{
  given $type
  {
	when ANIMATION_PARAM_DOES_NOT_MATCH_FORWARD {
		error_header();
		$*ERR.say( "The animation block's parameter does not match ",
			"the parameter specified in the forward statement." );
	}
	when ANIMATION_PARAMETER_NAME_NOT_UNIQUE {
		error_header();
		$*ERR.say( "The animation parameter '", s1,
			"' is not a unique name. Animation parameters must have",
			" names that are unique in the global name space.");
	}
	when ARRAY_INDEX_MUST_BE_AN_INTEGER {
		error_header();
		# s2 is expected to be one of the following strings
		#	  "A double expression"
		#	  "A string expression"
		#	  "A animation_block expression"
		$*ERR.print( s2, " is not a legal array index. The array is '",
			s1, "'.");
			
		if (m_runtime)
		{
			$*ERR.print( "	Element '", s1, "[0]' will be used instead.");
		}
		
		$*ERR.say();
	}
	when ARRAY_INDEX_OUT_OF_BOUNDS {
		error_header();
		$*ERR.print( "Index value '", s2, "' is out of bounds for array '",
			s1, "'.");
		
		if (m_runtime)
		{
			$*ERR.print("  Element '", s1, "[0]' will be used instead.");
		}
		$*ERR.say();
	}
	when ASSIGNMENT_TYPE_ERROR {
		error_header();
		$*ERR.say( "Cannot assign an expression of type '", s2,
			"' to a variable of type '", s1, "'.");
	}
	when ANIMATION_BLOCK_ASSIGNMENT_PARAMETER_TYPE_ERROR {
		error_header();
		$*ERR.say( "Cannot assign an animation block with parameter of type '",
			s2, "' to an animation block with parameter of type '", s1, "'.");
	}
	
	# some attributes (such as h & w in a circle) cannot be changed
	when CANNOT_CHANGE_DERIVED_ATTRIBUTE {
		error_header();
		$*ERR.print( "Cannot changed derived field '", s1, "' of a '", s2,
			"' object. This field is derived from other fields. ");
		if (m_runtime){
			$*ERR.print( "The change will be ignored." );
		}
		$*ERR.say();
	}
	when EXIT_STATUS_MUST_BE_AN_INTEGER {
		error_header();
		$*ERR.say( "Value passed to exit() must be an integer. ",
			"Value passed was of type '", s1, "'.");
	}

	# this error originates from gpl.y when it finds an illegal token
	when ILLEGAL_TOKEN {
		$*ERR.say( "Syntax error on line ", line_count,
			" '", s1, "' is not a legal token.");
	}
	when INCORRECT_CONSTRUCTOR_PARAMETER_TYPE {
		error_header();
		$*ERR.say( "Incorrect type for parameter '",
			s2, "' of object ", s1, ".");
	}
	when INVALID_ARRAY_SIZE {
		error_header();
		$*ERR.say("The array '", s1, "' was declared with illegal size '",
			s2, "'. Arrays sizes must be integers of 1 or larger.");
	}
	
	# everything but a game object is a legal LHS of assignment
	when INVALID_LHS_OF_ASSIGNMENT {
		error_header();
		$*ERR.say( "LHS of assignment must be ",
			"(INT || DOUBLE || STRING || ANIMATION_BLOCK).",
			"  Variable '", s1, "' is of type '", s2, "'." );
	}
	when INVALID_LHS_OF_PLUS_ASSIGNMENT {
		error_header();
		$*ERR.say( "LHS of plus-assignment must be (INT || DOUBLE || STRING).",
			"  Variable '", s1, "' is of type '", s2, "'." );
	}
	when INVALID_LHS_OF_MINUS_ASSIGNMENT {
		error_header();
		$*ERR.say( "LHS of minus-assignment must be (INT || DOUBLE).",
			"  Variable '", s1, "' is of type '", s2, "'." );
	}
	when INVALID_LHS_OF_PLUS_PLUS {
		error_header();
		$*ERR.say( "LHS of ++ must be INT.", "  Variable '", s1,
			"' is of type '", s2, "'.");
	}
	when INVALID_LHS_OF_MINUS_MINUS {
		error_header();
		$*ERR.say( "LHS of -- must be INT.", "  Variable '", s1,
			"' is of type '", s2, "'.");
	}
	when INVALID_LEFT_OPERAND_TYPE {
		error_header();
		$*ERR.say( "Invalid left operand for operator '", s1, "'.");
	}
	when INVALID_RIGHT_OPERAND_TYPE {
		error_header();
		$*ERR.say( "Invalid right operand for operator '", s1, "'.");
	}
	when INVALID_TYPE_FOR_INITIAL_VALUE {
		error_header();
		$*ERR.say( "Incorrect type (", s1, ") for initial value of variable '",
			s2, "' of type (", s3, ").");
	}
	when INVALID_TYPE_FOR_FOR_STMT_EXPRESSION {
		error_header();
		$*ERR.say("Incorrect type for expression in for statement.",
			"  Expressions in for statements must be of type INT.");
	}
	when INVALID_TYPE_FOR_IF_STMT_EXPRESSION {
		error_header();
		$*ERR.say( "Incorrect type for expression in an if statement.",
			"  Expressions in if statements must be of type INT.");
	  }
	when INVALID_TYPE_FOR_PRINT_STMT_EXPRESSION {
		error_header();
		$*ERR.say( "Incorrect type for expression in a print statement.",
			"  Expressions in print statements must be",
			" of type INT, DOUBLE, or STRING.");
	}
	when INVALID_TYPE_FOR_RESERVED_VARIABLE {
		error_header();
		$*ERR.say( "Incorrect type for reserved variable '", s1,
			"'. It was declared with type '", s2,
			"'. It must be of type '", s3, "'.");
	}
	when INVALID_ARGUMENT_FOR_RANDOM {
		# This is an unsual error.  If discovered at parse time, the program
		# is terminated as with all other errors.
		# If discovered at run time, the program issues the error and 
		# using 2 as the default.
		error_header();
		$*ERR.print("Illegal argument to random()<", s1, ">. Must be >= 1.");
		
		if (m_runtime){
			$*ERR.print("  Using 2 as the range.");
		}
		
		$*ERR.say();
	}
	when LHS_OF_PERIOD_MUST_BE_OBJECT {
		error_header();
		$*ERR.say("Variable '", s1, "' is not an object.",
			"  Only objects may be on the left of a period.");
	}
	when MINUS_ASSIGNMENT_TYPE_ERROR {
		error_header();
		$*ERR.say( "Cannot -= an expression of type '", s2,
			"' from a variable of type '", s1, "'.");
	}
	when NO_BODY_PROVIDED_FOR_FORWARD {
		error_header();
		$*ERR.say( "No body was provided for animation block '", s1,
			"' which was declared in a forward statement.");
	}
	when NO_FORWARD_FOR_ANIMATION_BLOCK {
		error_header();
		$*ERR.say( "There is not a forward statement for animation block '",
			s1, "'.");
	}
	
	# game objects are the only valid operands for near and touches
	when OPERAND_MUST_BE_A_GAME_OBJECT {
		error_header();
		$*ERR.say( "Operand '", s1, "' must be a Game_object ",
			"(circle, rectangle, triangle, etc.)");
	}
	
	# only called in gpl.cpp when parser finds an error
	# called from yyerror()
	when PARSE_ERROR {
		$*ERR.say( "Parse error on line ", line_count,
			" reported by parser: ", s1, ".");
	}
	when PLUS_ASSIGNMENT_TYPE_ERROR {
		error_header();
		$*ERR.say( "Cannot += an expression of type '", s2,
			"' to a variable of type '", s1, "'.");
	}
	when PREVIOUSLY_DECLARED_VARIABLE {
		error_header();
		$*ERR.say( "Variable '", s1, "'", " previously declared.");
	}
	when PREVIOUSLY_DEFINED_ANIMATION_BLOCK {
		error_header();
		$*ERR.say( "A statement block for the animation block '", s1, "'",
			" has already been defined.");
	  }
	when TYPE_MISMATCH_BETWEEN_ANIMATION_BLOCK_AND_OBJECT {
		error_header();
		$*ERR.say( "The type of object '", s1, "'",
			" does not match the type of the parameter to the ",
			"animation block '", s2, "'");
	}
	when UNDECLARED_MEMBER {
		error_header();
		$*ERR.say( "Object '", s1, "'",
			" does not contain the member variable '", s2, "'.");
	}
	when UNDECLARED_VARIABLE {
		error_header();
		$*ERR.say( "Variable '", s1, "'",
			" was not declared before it was used.");
	}
	when UNKNOWN_CONSTRUCTOR_PARAMETER {
		error_header();
		$*ERR.say( "Game object '", s1, "' does not have a parameter called '",
			s2, "'.");
	}
	when VARIABLE_NOT_AN_ARRAY {
		error_header();
		$*ERR.say("Variable '", s1, "' is not an array.");
	}
	when VARIABLE_IS_AN_ARRAY {
		error_header();
		$*ERR.say("Variable '", s1, "' is an array.");
	}
	when DIVIDE_BY_ZERO_AT_PARSE_TIME {
		error_header();
		$*ERR.say("Arithmetic divide by zero at parse time. ",
			"Using zero as the result so parse can continue.");
	}
	when MOD_BY_ZERO_AT_PARSE_TIME {
		error_header();
		$*ERR.say("Arithmetic mod by zero at parse time. ",
			"Using zero as the result so parse can continue.");
	}
	when UNDEFINED_ERROR {
		error_header();
		$*ERR.say("Undefined error passed to Error::error(). ",
			"This is probably because error.cpp was not updated ",
			"when a new error was added to error.h.");
	}
	default {
		$*ERR.say("Unknown error sent to class Error::error().");
	}
  }
  $m_num_errors++;
}

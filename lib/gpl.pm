
grammar Gpl 
{
	token TOP { <T_INT> }
		
	
	token T_INT					{ 'int' }
	token T_DOUBLE				{ 'double' }
	token T_STRING				{ 'string' }
	token T_TRIANGLE			{ 'triangle' }
	token T_PIXMAP				{ 'pixmap' }
	token T_CIRCLE				{ 'circle' }
	token T_RECTANGLE			{ 'rectangle' }
	token T_TEXTBOX				{ 'textbox' }
	token T_FORWARD				{ 'forward' } # value is line number
	token T_INITIALIZATION		{ 'initialization' }
	token T_TERMINATION			{ 'termination' }

	token T_TRUE				{ 'true' }
	token T_FALSE				{ 'false' }

	token T_TOUCHES				{ 'touches' }
	token T_NEAR				{ 'near' }

	token T_ANIMATION			{ 'animation' }

	token T_IF					{ 'if' }
	token T_FOR					{ 'for' }
	token T_ELSE				{ 'else' }
	token T_PRINT				{ 'print' } # value is line number
	token T_EXIT				{ 'exit' } # value is line number

	token T_LPAREN				{ '(' }
	token T_RPAREN				{ ')' }
	token T_LBRACE				{ '{' }
	token T_RBRACE				{ '}' }
	token T_LBRACKET			{ '[' }
	token T_RBRACKET			{ ']' }
	token T_SEMIC				{ ';' }
	token T_COMMA				{ ',' }
	token T_PERIOD				{ '.' }

	token T_ASSIGN				{ '=' }
	token T_PLUS_ASSIGN			{ '+=' }
	token T_MINUS_ASSIGN		{ '-=' }
	token T_PLUS_PLUS			{ '++' }
	token T_MINUS_MINUS			{ '--' }

	token T_MULTIPLY			{ '*' }
	token T_DIVIDE				{ '/' }
	token T_MOD					{ '%' }
	token T_PLUS				{ '+' }
	token T_MINUS				{ '-' }
	token T_SIN					{ 'sin' }
	token T_COS					{ 'cos' }
	token T_TAN					{ 'tan' }
	token T_ASIN				{ 'asin' }
	token T_ACOS				{ 'acos' }
	token T_ATAN				{ 'atan' }
	token T_SQRT				{ 'sqrt' }
	token T_FLOOR				{ 'floor' }
	token T_ABS					{ 'abs' }
	token T_RANDOM				{ 'random' }

	token T_LESS				{ '<' }
	token T_GREATER				{ '>' }
	token T_LESS_EQUAL			{ '<=' }
	token T_GREATER_EQUAL		{ '>=' }
	token T_EQUAL				{ '==' }
	token T_NOT_EQUAL			{ '!=' }

	token T_AND					{ '&&' }
	token T_OR					{ '||' }
	token T_NOT					{ '!' }

	token T_ON					{ 'on' }
	token T_SPACE				{ 'space' }
	token T_LEFTARROW			{ 'leftarrow' }
	token T_RIGHTARROW			{ 'rightarrow' }
	token T_UPARROW				{ 'uparrow' }
	token T_DOWNARROW			{ 'downarrow' }
	token T_LEFTMOUSE_DOWN		{ 'leftmouse_down' }
	token T_MIDDLEMOUSE_DOWN	{ 'middlemouse_down' }
	token T_RIGHTMOUSE_DOWN		{ 'rightmouse_down' }
	token T_LEFTMOUSE_UP		{ 'leftmouse_up' }
	token T_MIDDLEMOUSE_UP		{ 'middlemouse_up' }
	token T_RIGHTMOUSE_UP		{ 'rightmouse_up' }
	token T_MOUSE_MOVE			{ 'mouse_move' }
	token T_MOUSE_DRAG			{ 'mouse_drag' }
	token T_F1					{ 'f1' }
	token T_AKEY				{ 'akey' }
	token T_SKEY				{ 'skey' }
	token T_DKEY				{ 'dkey' }
	token T_FKEY				{ 'fkey' }
	token T_HKEY				{ 'hkey' }
	token T_JKEY				{ 'jkey' }
	token T_KKEY				{ 'kkey' }
	token T_LKEY				{ 'lkey' }
	token T_WKEY				{ 'wkey' }

	token T_ID					{ <[a..z A..Z]><[0..9 a..z A..Z _]> }
	token T_INT_CONSTANT		{ \d+ }
	token T_DOUBLE_CONSTANT		{ \d+.\d* | \d*.\d+ }
	token T_STRING_CONSTANT		{ \" <-["]>* \" } #" fix syntax highlighter

	# special token that does not match any production
	# used for characters that are not part of the language
	token T_ERROR				{ 'fnord?' }
	token ws					{ }
}

class GplActions
{
}
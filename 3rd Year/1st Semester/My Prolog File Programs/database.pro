database
	employee(symbol,integer,real).
predicates
	run
	show
clauses
	run:-
		assert(employee(ahmed,35,2000)),
		assert(employee(ali,0,2500)),
		assert(employee(zaki,37,23000)),
		save("C:\\empdb.txt").
	show:-
		existfile("C:\\empdb.txt"),
		consult("C:\\empdb.txt").
goal
	run,show.
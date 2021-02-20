%% DESCRIPTION: If a locum solicitor would be prohibited by section 34(1)(b), but is permitted
%% DESCRIPTION: by section 34(5), the prohibition does not hold, and the permission does.

#include 'basic_facts.pl'.
#include '../s34.pl'.

locum_solicitor(jason).
materially_interferes_with(ceo_megaCorp,availability,jason).
conditions_of_second_schedule_satisfied.

?- according_to(s34_1,must_not(jason,accept,ceo_megaCorp)), 
   according_to(s34_5,may(jason,accept,ceo_megaCorp)),
   holds(may(jason,accept,ceo_megaCorp)).
%% DESCRIPTION: Without more, jason cannot take a position in megaCorp
%% DESCRIPTION: because it is a business entity under 34(6)(b).

#include 'basic_facts.pl'.
#include '../s34.pl'.

?- according_to(s34_6_b,must_not(jason,accept,ceo_megaCorp)).
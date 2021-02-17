% This is a version os s34 amended to reflect amendments 1  and 2,
% with various predicates made abducible to allow for an analysis of
% the text in the abstract.

#pred according_to(X,may(Y,accept,Z)) :: 'in accordance with @(X), @(Y) is permitted to accept @(Z)'.
#pred according_to(X,must_not(Y,accept,Z)) :: 'in accordance with @(X), @(Y) is prohibited from accepting @(Z)'.
#pred according_to(X,Y) :: 'in accordance with @(X), @(Y)'.
#pred holds(may(Y,accept,Z)) :: 'it holds that @(Y) is permitted to accept @(Z)'.
#pred holds(must_not(Y,accept,Z)) :: 'it holds that @(Y) is prohibited from accepting @(Z)'.
#pred holds(X) :: '@(X) holds'.
#pred defeated(X,Y) :: 'the conclusion from @(X) of @(Y) is defeated'.

holds(Holding) :-
    according_to(Section,Holding),
    not defeated(Section,Holding).

% 34. Executive appointments
% 34.—(1)  A legal practitioner must not accept any executive appointment associated with 
% any of the following businesses:

% IN THIS FILE, AMENDED TO:
% 34.—(1)  A legal practitioner must not accept any executive appointment
%               a) associated with any of the following businesses, or
%               b) in a business entity or law practice that carries on any of the following businesses:


#pred legal_practitioner(X) :: '@(X) is a legal practitioner'.
#abducible legal_practitioner(X).
#pred must_not(A,accept,B) :: '@(A) must not accept @(B)'.
#pred executive_appointment(A) :: '@(A) is an executive appointment'.
#abducible executive_appointment(A).
#pred associated_with(A,B) :: '@(A) is associated with @(B)'.
#abducible associated_with(A,B).
#pred described_in_s1(B) :: '@(B) is a business described in 34(1)'.

according_to(s34_1,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    associated_with(Appointment,Business),
    business(Business),
    holds(described_in_s1(Business)).


according_to(s34_1,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    in(Appointment,BusinessEntity),
    business_entity(BusinessEntity),
    carries_on(BusinessEntity,Business),
    holds(described_in_s1(Business)).

according_to(s34_1,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    in(Appointment,LawPractice),
    law_practice(LawPractice),
    carries_on(LawPractice,Business),
    holds(described_in_s1(Business)).

% Not clear if I should be using holds/1 here instead of naming the sub-paragraphs individually.

#pred according_to(X,described_in_s1(Y)) :: 'according to @(X), @(Y) is described in section 1'.

% (a)	any business which detracts from, is incompatible with, or derogates from the dignity of,
% the legal profession;
#pred detracts_from_dignity_of_legal_profession(X) :: '@(X) detracts from the dignity of the legal profession'.
#abducible detracts_from_dignity_of_legal_profession(X).
#pred incompatible_dignity_of_legal_profession(X) :: '@(X) is incompatible with the dignity of the legal profession'.
#abducible incompatible_dignity_of_legal_profession(X).
#pred derogates_from_dignity_of_legal_profession(X) :: '@(X) derogates from the dignity of the legal profession'.
#abducible derogates_from_dignity_of_legal_profession(X).

according_to(s34_1_a,described_in_s1(Business)) :- business(Business), detracts_from_dignity_of_legal_profession(Business).
according_to(s34_1_a,described_in_s1(Business)) :- business(Business), incompatible_dignity_of_legal_profession(Business).
according_to(s34_1_a,described_in_s1(Business)) :- business(Business), derogates_from_dignity_of_legal_profession(Business).

%% IN THIS FILE, section 1(b) REMOVED

#pred materially_interferes_with(X,Y,Z) :: '@(X) materially interferes with @(Y) with regard to @(Z)'.
#abducible materially_interferes_with(X,Y,Z).
#pred primary_occupation_of(X,Y) :: '@(Y) is the primary occupation of @(X)'.
#abducible primary_occupation_of(X,Y).

% (c)	any business which is likely to unfairly attract business in the practice of law;
#pred unfair(X) :: '@(X) is likely to unfairly attract business in the practice of law'.
#abducible unfair(X).

according_to(s34_1_c,described_in_s1(X)) :- unfair(X).

% (d)	any business which involves the sharing of the legal practitioner’s fees with, 
% or the payment of a commission to, any unauthorised person for legal work performed 
% by the legal practitioner;
#pred involves_sharing_fees(X,Y,Z) :: '@(X) involves sharing @(Y) with @(Z)'.
#abducible involves_sharing_fees(X,Y,Z).
#pred as_compensation_for(A,B) :: '@(A) is provided as compensation in respect of @(B)'.
#abducible as_compensation_for(A,B).
#pred performed_by(A,B) :: '@(A) was performed by @(B)'.
#abducible performed_by(A,B).
#pred legal_work(X) :: '@(X) is legal work'.
#abducible legal_work(X).
#pred unauthorized(X) :: '@(X) is unauthorised to peform legal work'.
#abducible unauthorized(X).
#pred involves_paying_commission(X,Y,Z) :: '@(X) involves paying @(Y) to @(Z)'.
#abducible involves_paying_commission(X,Y,Z).

according_to(s34_1_d,described_in_s1(X)) :- involves_sharing_fees(X,Fees,Recipient), as_compensation_for(Fees,Work), performed_by(Work,Lawyer), legal_work(Work), unauthorized(Recipient).
according_to(s34_1_d,described_in_s1(X)) :- involves_paying_commission(X,Fees,Recipient), as_compensation_for(Fees,Work), performed_by(Work,Lawyer), legal_work(Work), unauthorized(Recipient).

% (e)	any business set out in the First Schedule;
#pred described_in_first_schedule(X) :: '@(X) is set out in the first schedule'.
#abducible described_in_first_schedule(X).

according_to(s34_1_e,described_in_s1(X)) :- described_in_first_schedule(X).

% (f)	any business which is prohibited by —
% (i)	the Act;
% (ii)	these Rules or any other subsidiary legislation made under the Act;
% (iii)	any practice directions, guidance notes and rulings issued under section 71(6) of the Act; or
% (iv)	any practice directions, guidance notes and rulings (relating to professional practice,
%  etiquette, conduct and discipline) issued by the Council or the Society.
#pred prohibited_business(X) :: '@(X) is a business which is prohibited as defined by section 34(1)(f)'.
#abducible prohibited_business(X).

according_to(s34_1_f,described_in_s1(X)) :- prohibited_business(X).

%% THE AMENDMENT INSERTS THIS SECTION IN PLACE OF s34(1)(b)
%% 1A (to place it between 1 and 2): A legal practitioner must not accept any executive appointment that:
%% materially interferes with —
% (i)	the legal practitioner’s primary occupation of practising as a lawyer;
% (ii)	the legal practitioner’s availability to those who may seek the legal practitioner’s 
% services as a lawyer; or
% (iii)	the representation of the legal practitioner’s clients.

%% NOTE: In the legislative text, the numbering would be different. In the code, the number of
%% the section is left as s34_1_b solely so that we do not need to rewrite the tests in order
%% for them to work.

according_to(s34_1_b,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    materially_interferes_with(Appointment,practicing_as_a_lawyer,Lawyer),
    primary_occupation_of(Lawyer,practicing_as_a_lawyer).

according_to(s34_1_b,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    materially_interferes_with(Appointment,availability,Lawyer).

according_to(s34_1_b,must_not(Actor, accept, Appointment)) :-
    legal_practitioner(Actor),
    executive_appointment(Appointment),
    materially_interferes_with(Appointment,representation,Lawyer).

% (2)  Subject to paragraph (1), a legal practitioner in a Singapore law practice 
% (called in this paragraph the main practice) may accept an executive appointment 
% in another Singapore law practice (called in this paragraph the related practice), 
% if the related practice is connected to the main practice in either of the following ways:
% (a)	every legal or beneficial owner of the related practice is the sole proprietor, 
% or a partner or director, of the main practice;

#pred owner_of(X,Y) :: '@(X) is the legal or beneficial owner of @(Y)'.
#pred legal_owner_of(X,Y) :: '@(X) is a legal owner of @(Y)'.
#abducible legal_owner_of(X,Y).
#pred beneficial_owner_of(X,Y) :: '@(X) is a beneficial owner of @(Y)'.
#abducible beneficial_owner_of(X,Y).
#pred partner_of(X,Y) :: '@(X) is a partner of @(Y)'.
#abducible partner_of(X,Y).
#pred sole_proprietor_of(X,Y) :: '@(X) is the sole proprietor of @(Y)'.
#abducible sole_proprietor_of(X,Y).
#pred director_of(X,Y) :: '@(X) is a director of @(Y)'.
#abducible director_of(X,Y).
#pred owner_and_not_partner_of(Y,Z) :: 'someone who is a legal or beneficial owner of @(Y) is not a sole proprietor, partner, or director of @(Z)'.
#pred may(A,accept,B) :: '@(A) may accept an appoinment to @(B)'.
#pred partner_sp_or_director_of(X,Y) :: '@(X) is a partner, sole proprietor, or director of @(Y)'.

according_to(s34_2_a,may(LP,accept,EA)) :-
    legal_practitioner(LP),
    in(LP,Main_Practice),
    law_practice(Main_Practice),
    jurisdiction(Main_Practice,singapore),
    executive_appointment(EA),
    in(EA,Other_Practice),
    law_practice(Other_Practice),
    jurisdiction(Other_Practice,singapore),
    not owner_and_not_partner_of(Other_Practice,Main_Practice).

defeated(s34_2_a,may(LP,accept,EA)) :-
    according_to(s34_1,must_not(LP,accept,EA)),
    not defeated(s34_1,must_not(LP,accept,EA)).

% THIS AMENDMENT AMENDS THIS DEFEASIBILITY STATEMENT TO ADD THE FOLLOWING
defeated(s34_2_a,may(LP,accept,EA)) :-
    according_to(s34_1_b,must_not(LP,accept,EA)),
    not defeated(s34_1_b,must_not(LP,accept,EA)).

owner_of(X,Y) :-
    legal_owner_of(X,Y).
owner_of(X,Y) :-
    beneficial_owner_of(X,Y).

partner_sp_or_director_of(X,Y) :-
    partner_of(X,Y).
partner_sp_or_director_of(X,Y) :-
    sole_proprietor_of(X,Y).
partner_sp_or_director_of(X,Y) :-
    director_of(X,Y).

owner_and_not_partner_of(Y,Z) :-
    owner_of(X,Y),
    not partner_sp_or_director_of(X,Z).

% (b)	the legal practitioner accepts the executive appointment as a representative 
% of the main practice in the related practice, and the involvement of the main practice 
% in the related practice is not prohibited by any of the following:
% (i)	the Act;
% (ii)	these Rules or any other subsidiary legislation made under the Act;
% (iii)	any practice directions, guidance notes and rulings issued under section 71(6) of the Act;
% (iv)	any practice directions, guidance notes and rulings (relating to professional practice,
% etiquette, conduct and discipline) issued by the Council or the Society.

#pred accepts_position_as_representative(A,B,C) :: '@(A) accepts the position @(B) as a representative of @(C)'.
#abducible accepts_position_as_representative(A,B,C).
#pred must_not(A,participate,B) :: '@(A) is prohibited from participating in @(B)'.

according_to(s34_2_b,may(LP,accept,EA)) :-
    legal_practitioner(LP),
    in(LP,Main_Practice),
    law_practice(Main_Practice),
    jurisdiction(Main_Practice,singapore),
    executive_appointment(EA),
    in(EA,Other_Practice),
    law_practice(Other_Practice),
    jurisdiction(Other_Practice,singapore),
    accepts_position_as_representative(LP,EA,Main_Practice),
    not holds(must_not(Main_Practice,participate,Other_Practice)). % this is a low-fidelity representation of the prohibition.

defeated(s34_2_b,may(LP,accept,EA)) :-
    according_to(s34_1,must_not(LP,accept,EA)),
    not defeated(s34_1,must_not(LP,accept,EA)).
    
% THIS AMENDMENT ADDS:
defeated(s34_2_b,may(LP,accept,EA)) :-
    according_to(s34_1_b,must_not(LP,accept,EA)),
    not defeated(s34_1_b,must_not(LP,accept,EA)).


% (3)  Subject to paragraph (1), a legal practitioner may accept an executive appointment 
% in a business entity which provides law-related services.
#pred provides(A,B) :: '@(A) provides @(B)'.
#abducible provides(A,B).

according_to(s34_3,may(LP,accept,EA)) :-
    legal_practitioner(LP),
    executive_appointment(EA),
    business_entity(BE),
    in(EA,BE),
    provides(BE,LRS),
    law_related_service(LRS).

defeated(s34_3,may(LP,accept,EA)) :-
    according_to(s34_1,must_not(LP,accept,EA)),
    not defeated(s34_1,must_not(LP,accept,EA)).

% THIS AMENDMENT ADDS:

defeated(s34_3,may(LP,accept,EA)) :-
    according_to(s34_1_b,must_not(LP,accept,EA)),
    not defeated(s34_1_b,must_not(LP,accept,EA)).


% (4)  Subject to paragraph (1), a legal practitioner (not being a locum solicitor) may 
% accept an executive appointment in a business entity which does not provide any 
% legal services or law-related services, if all of the conditions set out in the 
% Second Schedule are satisfied.

#pred legal_service(X) :: '@(X) is a legal service'.
#abducible legal_service(X).
#pred conditions_of_second_schedule_satisfied :: 'the conditions of the second schedule are satisfied'.
#abducible conditions_of_second_schedule_satisfied.

according_to(s34_4,may(LP,accept,EA)) :-
    legal_practitioner(LP),
    not locum_solicitor(LP),
    executive_appointment(EA),
    business_entity(BE),
    in(EA,BE),
    not provides_legal_or_law_related_services(BE),
    conditions_of_second_schedule_satisfied.

defeated(s34_4,may(LP,accept,EA)) :-
    according_to(s34_1,must_not(LP,accept,EA)),
    not defeated(s34_1,must_not(LP,accept,EA)).

% This amendment adds:

defeated(s34_4,may(LP,accept,EA)) :-
    according_to(s34_1_b,must_not(LP,accept,EA)),
    not defeated(s34_1_b,must_not(LP,accept,EA)).


% (5)  Despite paragraph (1)(b), but subject to paragraph (1)(a) and (c) to (f), 
% a locum solicitor may accept an executive appointment in a business entity which 
% does not provide any legal services or law-related services, if all of the 
% conditions set out in the Second Schedule are satisfied.

#pred locum_solicitor(X) :: '@(X) is a locum solicitor'.
#abducible locum_solicitor(X).

according_to(s34_5,may(LP,accept,EA)) :-
    legal_practitioner(LP),
    locum_solicitor(LP),
    executive_appointment(EA),
    business_entity(BE),
    in(EA,BE),
    not provides_legal_or_law_related_services(BE),
    conditions_of_second_schedule_satisfied.

#pred provides_legal_or_law_related_services(X) :: '@(X) provides legal or law-related services'.

provides_legal_or_law_related_services(BE) :-
    provides(BE,Serv),
    legal_service(Serv).

provies_legal_or_law_related_services(BE) :-
    provides(BE,Serv),
    law_related_service(Serv).

%% WITH THIS AMENDMENT, THE DEFEASIBILITY STATEMENT IS SIMPLIFIED
defeated(s34_5,may(LP,accept,EA)) :-
    according_to(s34_1,must_not(LP,accept,EA)),
    not defeated(s34_1,must_not(LP,accept,EA)).

defeated(s34_1_b,must_not(LP,accept,EA)) :-
    according_to(s34_5,may(LP,accept,EA)),
    not defeated(s34_5,may(LP,accept,EA)).

% (6)  Except as provided in paragraphs (2) to (5) —
% (a)	a legal practitioner in a Singapore law practice must not accept any executive 
% appointment in another Singapore law practice; and
according_to(s34_6_a,must_not(LP,accept,EA)) :-
    legal_practitioner(LP),
    executive_appointment(EA),
    law_practice(Other_Practice),
    in(EA,Other_Practice),
    not in(LP,Other_Practice).

defeated(s34_6_a,must_not(LP,accept,EA)) :-
    according_to(s34_2_a,may(LP,accept,EA)),
    not defeated(s34_2_a,may(LP,accept,EA)).
defeated(s34_6_a,must_not(LP,accept,EA)) :-
    according_to(s34_2_b,may(LP,accept,EA)),
    not defeated(s34_2_b,may(LP,accept,EA)).
defeated(s34_6_a,must_not(LP,accept,EA)) :-
    according_to(s34_3,may(LP,accept,EA)),
    not defeated(s34_3,may(LP,accept,EA)).
defeated(s34_6_a,must_not(LP,accept,EA)) :-
    according_to(s34_4,may(LP,accept,EA)),
    not defeated(s34_4,may(LP,accept,EA)).
defeated(s34_6_a,must_not(LP,accept,EA)) :-
    according_to(s34_5,may(LP,accept,EA)),
    not defeated(s34_5,may(LP,accept,EA)).

% (b)	a legal practitioner must not accept any executive appointment in a business entity.
according_to(s34_6_b,must_not(LP,accept,EA)) :-
    legal_practitioner(LP),
    executive_appointment(EA),
    business_entity(BE),
    in(EA,BE).

defeated(s34_6_b,must_not(LP,accept,EA)) :-
    according_to(s34_2_a,may(LP,accept,EA)),
    not defeated(s34_2_a,may(LP,accept,EA)).
defeated(s34_6_b,must_not(LP,accept,EA)) :-
    according_to(s34_2_b,may(LP,accept,EA)),
    not defeated(s34_2_b,may(LP,accept,EA)).
defeated(s34_6_b,must_not(LP,accept,EA)) :-
    according_to(s34_3,may(LP,accept,EA)),
    not defeated(s34_3,may(LP,accept,EA)).
defeated(s34_6_b,must_not(LP,accept,EA)) :-
    according_to(s34_4,may(LP,accept,EA)),
    not defeated(s34_4,may(LP,accept,EA)).
defeated(s34_6_b,must_not(LP,accept,EA)) :-
    according_to(s34_5,may(LP,accept,EA)),
    not defeated(s34_5,may(LP,accept,EA)).

% (7)  To avoid doubt, nothing in this rule prohibits a legal practitioner 
% from accepting any appointment in any institution set out in the Third Schedule.

according_to(s34_7,may(LP,accept,P)) :-
    legal_practitioner(LP),
    position(P),
    institution(I),
    in(P,I),
    in_third_schedule(I).

% Consider asserting that it is strict?
% -defeated(s34_7,may(LP,accept,P)) :- true.

% TODO: it would be useful to test whether or not this rule changes anything.
% TODO: it would also be instructive to implement this as a formal verification task, as opposed to a new rule.

% (8)  To avoid doubt, this rule does not authorise the formation of, or regulate —
% (a)	any related practice referred to in paragraph (2); or
% (b)	any business entity referred to in paragraph (3), (4) or (5).
% not modelled.

% (9)  In this rule and the First to Fourth Schedules —
% “business” includes any business, trade or calling in Singapore or elsewhere, 
% whether or not for the purpose of profit, but excludes the practice of law;
#pred business(X) :: '@(X) is a business for the purposes of section 34'.
#pred for_profit(X) :: '@(X) is for profit'.
#abducible for_profit(X).
#pred -for_profit(X) :: '@(X) is not for profit'.
#pred trade(X) :: '@(X) is a trade'.
#abducible trade(X).
#pred calling(X) :: '@(X) is a calling'.
#abducible calling(X).

business(X) :- business(X), in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- trade(X), in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- calling(X),  in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- business(X), in(X,singapore), -for_profit(X), X \= practice_of_law.
business(X) :- trade(X), in(X,singapore), -for_profit(X), X \= practice_of_law.
business(X) :- calling(X),  in(X,singapore), -for_profit(X), X \= practice_of_law.
business(X) :- business(X), -in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- trade(X), -in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- calling(X),  -in(X,singapore), for_profit(X), X \= practice_of_law.
business(X) :- business(X), -in(X,singapore), -for_profit(X), X \= practice_of_law.
business(X) :- trade(X), -in(X,singapore), -for_profit(X), X \= practice_of_law.
business(X) :- calling(X),  -in(X,singapore), -for_profit(X), X \= practice_of_law.

% the meaning of in(carpentry,singapore) is not clear to me.
% it is also not clear what for_profit(carpentry) would mean.
% neither has any legal effect, here, though.

% definiing business using business is circular, but doesn't cause problems in the code.

% “business entity”  —
% (a)	includes any company, corporation, partnership, limited liability partnership, 
% sole proprietorship, business trust or other entity that carries on any business; but
#pred business_entity(X) :: 'as per 34(7)(a) @(X) is a business entity for the purposes of section 34'.
#pred company(X) :: '@(X) is a company'.
#abducible company(X).
#pred corporation(X) :: '@(X) is a corporation'.
#abducible corporation(X).
#pred partnership(X) :: '@(X) is a partnership'.
#abducible partnership(X).
#pred llp(X) :: '@(X) is a limited liability partnership'.
#abducible llp(X).
#pred soleprop(X) :: '@(X) is a sole proprietorship'.
#abducible soleprop(X).
#pred business_trust(X) :: '@(X) is a business trust'.
#abducible business_trust(X).
#pred carries_on(X,Y) :: '@(X) carries on @(Y)'.
#abducible carries_on(X,Y).
#pred business(X) :: '@(X) is a business for the purposes of section 34'.

business_entity(X) :- carries_on(X,Y), business(Y), company(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), corporation(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), partnership(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), llp(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), soleprop(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), business_trust(X), not -business_entity(X).
business_entity(X) :- carries_on(X,Y), business(Y), not -business_entity(X).

% Syntactic ambiguity of whether carries on applies to all of the list.

% (b)	excludes any Singapore law practice, any Joint Law Venture, any Formal Law Alliance, 
% any foreign law practice and any institution set out in the Third Schedule;
#pred -business_entity(X) :: 'as per 34(7)(b), @(X) is not a business entity for the purposes of section 34'.
#pred law_practice(X) :: '@(X) is a law practice'.
#abducible law_practice(X).
#pred jurisdiction(X,Y) :: '@(X) is located in @(Y)'.
#abducible jurisdiction(X,Y).
#pred joint_law_venture(X) :: '@(X) is a joint law venture'.
#abducible joint_law_venture(X).
#pred formal_law_alliance(X) :: '@(X) is a formal law alliance'.
#abducible formal_law_alliance(X).
#pred foreign_law_practice(X) :: '@(X) is a foreign law practice'.
#abducible foreign_law_practice(X).
#pred institution(X) :: '@(X) is an institution'.
#abducible institution(X).
#pred in_third_schedule(X) :: '@(X) is listed in the third schedule'.
#abducible in_third_schedule(X).

-business_entity(X) :- law_practice(X), jurisdiction(X,singapore).
-business_entity(X) :- joint_law_venture(X).
-business_entity(X) :- formal_law_alliance(X).
-business_entity(X) :- foreign_law_practice(X).
-business_entity(X) :- institution(X), in_third_schedule(X).

% “executive appointment” means a position associated with a business, or in a business 
% entity or Singapore law practice, which entitles the holder of the position to perform 
% executive functions in relation to the business, business entity or Singapore law practice 
% (as the case may be), but excludes any non‑executive director or independent director 
% associated with the business or in the business entity;
#pred executive_appointment(X) :: '@(X) is an executive appointment for the purposes of section 34'.
#pred -executive_appointment(X) :: '@(X) is not an executive appointment for the purposes of section 34'.
#pred entitles_holder(X) :: '@(X) entitles the holder to perform executive functions'.
#abducible entitles_holder(X).
#pred position(X) :: '@(X) is a position'.
#abducible position(X).
#pred non_executive_director(X) :: '@(X) is a non-executive directorship'.
#abducible non_executive_director(X).
#pred independent_director(X) :: '@(X) is an independent directorship'.
#abducible independent_director(X).
#pred in(X,Y) :: '@(X) is in @(Y)'.
#abducible in(X,Y).

executive_appointment(X) :- position(X), entitles_holder(X), associated_with(X,Y), business(Y), not -executive_appointment(X).
executive_appointment(X) :- position(X), entitles_holder(X), in(X,Y), business_entity(Y), not -executive_appointment(X).
executive_appointment(X) :- position(X), entitles_holder(X), in(X,Y), law_practice(Y), jurisdiction(Y,singapore), not -executive_appointment(X).

-executive_appointment(X) :- non_executive_director(X), in(X,Y), business_entity(Y).
-executive_appointment(X) :- independent_director(X), in(X,Y), business_entity(Y).
-executive_appointment(X) :- non_executive_director(X), associated_with(X,Y), business(Y).
-executive_appointment(X) :- independent_director(X), associated_with(X,Y), business(Y).

% “law-related service” means any service set out in the Fourth Schedule, being a service 
% that may reasonably be performed in conjunction with, and that is in substance related 
% to, the provision of any legal service.
#pred law_related_service(X) :: '@(X) is a law-related service for the purposes of section 34'.
#pred service(X) :: '@(X) is a service'.
#abducible service(X).
#pred in_fourth_schedule(X) :: '@(X) is listed in the fourth schedule'.
#abducible in_fourth_schedule(X).

law_related_service(X) :- service(X), in_fourth_schedule(X).
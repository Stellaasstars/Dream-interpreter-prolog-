% Symbolic meanings of dream elements
symbol(water, "emotions and the subconscious mind").
symbol(flying, "freedom or desire to overcome obstacles").
symbol(falling, "fear of failure or loss of control").
symbol(tree, "growth and stability").
symbol(fire, "passion or transformation").

% Emotions and their meanings
emotion_meaning(happy, "positive personal growth").
emotion_meaning(anxious, "hidden worries or fears").
emotion_meaning(angry, "unresolved conflicts").
emotion_meaning(calm, "inner peace or acceptance").

% Actions and their meanings
action_meaning(running, "escaping from problems or responsibilities").
action_meaning(searching, "seeking answers or clarity").
action_meaning(helping, "desire to assist others or gain approval").
action_meaning(hiding, "fear of confrontation or being exposed").

% Ask about dream elements with input validation
ask_element(Element) :-
    format("Did your dream include ~w? (yes/no): ", [Element]),
    read(Response),
    handle_response(Response, Element, dream_element).

% Ask about emotions with input validation
ask_emotion(Emotion) :-
    format("Did you feel ~w in your dream? (yes/no): ", [Emotion]),
    read(Response),
    handle_response(Response, Emotion, dream_emotion).

% Ask about actions with input validation
ask_action(Action) :-
    format("Did you see ~w in your dream? (yes/no): ", [Action]),
    read(Response),
    handle_response(Response, Action, dream_action).

% Handle user responses
handle_response(yes, Fact, AssertPredicate) :-
    Call =.. [AssertPredicate, Fact],
    assertz(Call).

handle_response(no, _, _).
handle_response(_, Fact, AssertPredicate) :-
    write("Invalid input. Please enter 'yes' or 'no'."), nl,
    handle_response_helper(Fact, AssertPredicate).

% Helper predicate to re-prompt
handle_response_helper(Fact, AssertPredicate) :-
    format("Please answer for ~w again: (yes/no): ", [Fact]),
    read(NewResponse),
    handle_response(NewResponse, Fact, AssertPredicate).



% Dream Interpretation System
interpret_dream :-
    retractall(dream_element(_)),
    retractall(dream_emotion(_)),
    retractall(dream_action(_)),
    write("Dream Interpretation Expert System"), nl,
    write("Describe your dream by answering the following questions:"), nl,
    ask_element(water),
    ask_element(flying),
    ask_element(falling),
    ask_element(tree),
    ask_element(fire),
    ask_emotion(happy),
    ask_emotion(anxious),
    ask_emotion(angry),
    ask_emotion(calm),
    ask_action(running),
    ask_action(searching),
    ask_action(helping),
    ask_action(hiding),
    nl, write("Here is your dream interpretation:"), nl,
    write("Dream elements:"), nl,
    forall(dream_element(E), (symbol(E, Meaning), format("The element ~w represents: ~w.~n", [E, Meaning]))),
    write("Emotions:"), nl,
    forall(dream_emotion(E), (emotion_meaning(E, Meaning), format("Feeling ~w represents: ~w.~n", [E, Meaning]))),
    write("Actions:"), nl,
    forall(dream_action(A), (action_meaning(A, Meaning), format("The action ~w represents: ~w.~n", [A, Meaning]))),
    nl, write("Reflect on your dream's meaning and how it relates to your waking life."), nl.

RUN /vol/automed/data/usgs/load_tables.pig;

feature_name = 
    FOREACH feature
    GENERATE UPPER(state_name)
    AS state_name;

state_name = 
    FOREACH state
    GENERATE name;

feature_LJoin_state = 
    JOIN feature_name BY state_name LEFT,
    state_name BY name;

feature_without_state = 
    FILTER feature_LJoin_state
    BY name IS NULL;

feature_name_without_state = 
    FOREACH feature_without_state
    GENERATE state_name;

sorted_feature_name_without_state = 
    ORDER feature_name_without_state
    BY state_name;

DUMP sorted_feature_name_without_state;

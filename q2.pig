RUN /vol/automed/data/usgs/load_tables.pig

-- Project populated place for only state_code and population
projected_pp = 
    FOREACH populated_place {
        population = (population IS NULL ? 0 : population);
        elevation = (elevation IS NULL ? 0 : elevation);
        GENERATE state_code, population, elevation;
    }

-- Group by state_code
state_sum_group = 
    GROUP projected_pp 
    BY state_code;

-- Sum population for each state
state_sum = 
    FOREACH state_sum_group
    GENERATE group AS code,
        SUM (projected_pp.population) AS population,
        AVG (projected_pp.population) AS elevation;

dump state_sum;


# Queries

- [ ] Who won the most events?
To answer this question efficiently, we need a join table that's generated when
the matches are generated. Without the join table, as far as I can tell, we're
reduced to iterating over the records in Ruby because of how winners are
determined for the different types of matches. There are two sets of criteria
that determine a winner. For running and rowing events, the lowest time wins.
For the lifting events, the highest total amount of weight lifted wins. Thus,
determining the winners of an event requires aggregating the attempts of an
event.

As a result, I don't think it's possible to compute all the necessary
information in SQL to generate a table of all the winners for an event. This
question is most easily answered with a table that has two columns `event_id`
and `athlete_id`. Having this table allows grouping by athlete which in turn
allows us to return the number of wins per athlete.

- [x] How many of each different type of event occurred?
- [ ] Who won the most oly meets, powerlifting meets, runs, and rows?
- [ ] Who lifted the most weight per lifting movement?
- [ ] Who is the fastest runner? (for each distance)
- [ ] Who is the fastest rower? (for each distance)
- [ ] How many times did each athlete run Slow, Medium, Fast?
- [ ] How many times did each athlete row Slow, Medium, Fast?

**Athlete profiles**
- [x] personal records for each movement
- [ ] athlete won against the most
- [ ] athlete lost to the most

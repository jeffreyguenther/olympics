# Benchmark

The project description calls for generating 1 million events. 1 million events
will result in many more database records.

For example, a lifting event creates NUM_ATHLETES * MOVEMENTS * 3 ATTEMPTS.
As a concrete example, an olympic meet consists of three events. If the field
of athlete is 4, per the seed file, there are 4 * 3 * 3 + 1 = 37 records per event.
Multiply this by the number of events you want to generate, you will end up with
37 000 000 records. This is a non-trivial amount of data.

There are three ways this data can be imported:

1. Naïvely - you can generate an event and then store it. This means that you
will generate one SQL statement per record.

2. `INSERT INTO` - you can import the records in one SQL statement. Libraries
like [`activerecord-import`](https://github.com/zdennis/activerecord-import) and [`bulk_insert`](https://github.com/jamis/bulk_insert) reduce the work record to
generate the statement.

3. `COPY FROM` - While `INSERT INTO` is definitely faster than the naïve
approach, postgres provides a method specially designed for importing data. It
supports importing data from CSV files.

To discover the best way to import the data required by this project, I conducted
a small experiment. I benchmarked how long it took to import records using each
of these techniques. Unsurprisingly, using `COPY FROM` is the fastest.

Here's a description of the strategy:

1. Seed the db with athletes and movements for weightlifting. We need these
items to be stored in advance so we can use their ids when we generate the
events.

2. Generate the event results for each athlete. This can happen in memory and
without being persisted to the db because of the way the generation code is
architected.

3. Create and store each weightlifting event so you have an ID for the
weightlifting event. If you're starting with an empty database, you could load
all these items into an array and use the array index, but this was not a strategy
I explored yet.

4. Output all of the Attempts as a CSV file, streaming the data into the file
as it's generated.

5. Use `COPY FROM` to stream the data from the CSV (containing 36 M lines) to
the database.

Using a system with the specs:

* 4Ghz Core i7 - Late 2015, High Sierra
* 32 GB 1867 MHz DDR3

| Events         |  Tim(ms)       |
| :------------- | :------------- |
| 100            | 239            |
| 1000           | 2738           |
| 10_000         | 21733          |
| 100_000        | 247384         |
| 1_000_000      | 3161999        |
These results show that it takes 00:52:41 to import the million weightlifting events (37 million records)

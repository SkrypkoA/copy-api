### Requirements

1. Setup an airtable with the following dummy data:
    - Create [airtable.com](http://airtable.com/) account
    - Go to [https://airtable.com/account](https://airtable.com/account) and generate & copy the API key
    - Go to [https://airtable.com](https://airtable.com/) and click on `Add a base` from scratch and call it `Copy`
    - Set 2 columns called `Key` and `Copy`
    - Add 3 rows
        - `greeting`, `Hi {name}, welcome to {app}!`
        - `intro.created_at`, `Intro created on {created_at, datetime}`
        - `intro.updated_at`, `Intro updated on {updated_at, datetime}`
    - Add a few more rows of your own choosing
2. Setup a new ruby on rails backend server
3. Add a rake task to import `Copy` base from airtable & save it to a local JSON file (e.g. copy.json)
4. Load data from the local JSON file (e.g. copy.json) when the backend server starts up
5. Setup a `/copy` API endpoint that returns all the copy in JSON format
6. Setup a `/copy/{key}` API endpoint that returns the correct value associated with the key, for example:
    1. `/copy/greeting?name=John&app=Bridge` should return `{value: 'Hi John, welcome to Bridge!'}`
    2. `/copy/intro.created_at?created_at=1603814215` should return `{value: 'Intro created on Tues Oct 27 3:56:55PM'}`
    3. `/copy/intro.updated_at?updated_at=1604063144` should return `{value: 'Intro updated on Fri Oct 30 1:05:44PM'}`
7. Setup a `/copy/refresh` API endpoint that fetches latest copy data from airtable and updates the copy data **without** needing to re-run the rake task & restart the backend server
    1. Start the backend server
    2. Add a new row `time`, `It is {time, datetime}` in airtable
    3. Call `/copy/refresh` to refresh the copy data in the backend server
    4. `/copy/time?time=1604352707` should return `{value: 'It is Mon Nov 2 9:31:47PM'}`
8. Add `since` param support to `/copy` API endpoint that only returns copy data changes after the `since` param.
    - Hint: this logic shouldn't rely on the data fetched from airtable.
    - To demo it working:
        1. Start the backend server
        2. Get current epoch time, e.g. go to [https://www.epochconverter.com](https://www.epochconverter.com/) & copy it
        3. Update data in airtable
            1. Change `greeting` copy to `Hello {name}, welcome to {app}!`
            2. Add a new row `bye`, `Goodbye`
        4. Call `/copy/refresh` to refresh the copy data in the backend server
        5. `/copy?since=<current epoch time>` should **only** return the updated `greeting` copy and the new `bye` copy and **NOT** `intro.created_at`, `intro.updated_at` or `time` copy
        6. `/copy/greeting?name=John&app=Bridge` should return `{value: 'Hello John, welcome to Bridge!'}`
        7. `/copy/bye` should return `{value: 'Goodbye'}`
9. Record two videos, using [Loom.com](http://loom.com) if possible:
    1. Showing a working demo
    2. Walkthrough of the code
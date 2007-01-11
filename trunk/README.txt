= CalDAV

== To Do

* Generate VTIMEZONE

== Filtering

CalendarQuery.new.event #=> All events
CalendarQuery.new.event(time1..time2)
CalendarQuery.new.event.uid("UID")
CalendarQuery.new.todo.alarm(time1..time2)
CalendarQuery.new.event.attendee(email).partstat('NEEDS-ACTION')
CalendarQuery.new.todo.completed(false).status(:cancelled => false  )

@mycal.find(query)

== Results

CalendarResult.new.limit_recurrence_set(range)
CalendarResult.new.expand_recurrence(range)
CalendarResult.new.freebusy(range)


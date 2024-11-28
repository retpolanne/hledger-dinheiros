system("hledger print --pivot cat tag:kind=uber -O csv -o /tmp/uber-cur.csv --begin 2024-11-01 --end 2024-11-30")
system("hledger print --pivot cat tag:kind=uber -O csv -o /tmp/uber-prev.csv --begin 2024-10-01 --end 2024-10-30")

set datafile separator comma
set key autotitle columnhead

#set xdata time
#set timefmt "%Y-%m-%d"
#set xrange ["2024-11-01":"2024-11-30"]
set title "Uber cur/prev month graph"
set ylabel "amount spent with uber"
set xlabel "day of month"

plot "/tmp/uber-cur.csv" using :($9>0) with lines smooth cumulative, "/tmp/uber-prev.csv" using :($9>0) with lines smooth cumulative

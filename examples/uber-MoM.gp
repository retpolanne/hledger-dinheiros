reset session
system("hledger print --pivot cat tag:kind=uber -O csv -o /tmp/uber-cur.csv --begin 2024-12-01 --end 2024-12-31")
system("hledger print --pivot cat tag:kind=uber -O csv -o /tmp/uber-prev.csv --begin 2024-11-01 --end 2024-11-30")

datafile = "/tmp/uber-cur.csv"
datafile2 = "/tmp/uber-prev.csv"

set datafile separator comma
set key autotitle columnhead

set xdata time
set format x "%d"
set timefmt "%Y-%m-%d"
set xrange ["2024-11-01":"2024-12-31"]

set grid

set title "Uber cur/prev month graph"
set ylabel "amount spent with uber"
set xlabel "day of month"

#plot "/tmp/uber-cur.csv" using 2:($9>0) with lines smooth cumulative
plot datafile using 2:($9>0) with lines smooth cumulative, \
     datafile2 using 2:($9>0) with lines smooth cumulative

all: run

DeserBenchmark.class: DeserBenchmark.java
	javac DeserBenchmark.java

deser_benchmark: deser_benchmark.c
	gcc -Wall deser_benchmark.c --std=c99 -O2 -DLOOP=1000 -o deser_benchmark

run: DeserBenchmark.class deser_benchmark
	java -cp . DeserBenchmark 1700461846 10000000 1000
	./deser_benchmark

clean:
	rm -f *.class
	rm -f random.data
	rm -f deser_benchmark

.PHONY: clean run

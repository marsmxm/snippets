#include "apue.h"
#include <pthread.h>

int x = 0;
int y = 0;

void *
thr_fn1(void *arg)
{
	sleep(1);
	x = 1;
	int r1 = x;
	int r2 = y;
	printf("r1 = %d\n", r1);
	printf("r2 = %d\n", r2);
	return((void *)0);
}

void *
thr_fn2(void *arg)
{
	sleep(1);
	y = 1;
	int r3 = y;
	int r4 = x;
	printf("r3 = %d\n", r3);
	printf("r4 = %d\n", r4);
	return ((void *)0);
}

int
main(void)
{
	int		err;
	pthread_t t1;
	pthread_t t2;
	void *tret;

	err = pthread_create(&t1, NULL, thr_fn1, NULL);
	if (err != 0)
		err_exit(err, "can't create thread");

	err = pthread_create(&t2, NULL, thr_fn2, NULL);
	if (err != 0)
		err_exit(err, "can't create thread");

	pthread_join(t1, &tret);
	pthread_join(t2, &tret);

	exit(0);
}

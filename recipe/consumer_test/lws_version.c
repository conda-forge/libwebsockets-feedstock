#include <stdio.h>

#include <libwebsockets.h>

int main(void)
{
	printf("libwebsockets %s\n", lws_get_library_version());

	return 0;
}

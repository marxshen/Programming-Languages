#include "types.h"
#include "user.h"

#define stdin		0
#define stdout		1
#define stderr		2
#define O_RDONLY	0x0000
#define MAX_SIZE	512

int tolower(unsigned char ch) {
	if (ch >= 'A' && ch <= 'Z') ch += ('a'-'A');
	return ch;	
}

int strcmp_incase(const char *str1, const char *str2) {
	while (*str1 != '\0' || *str2 != '\0') {
		const unsigned char *u_str1 = (const unsigned char *)str1,
							*u_str2 = (const unsigned char *)str2;
		
		int diff = tolower(*u_str1) - tolower(*u_str2);
		if (diff != 0) return diff;
		++str1; ++str2;
	}
	return 0;
}

void print_mods(int fd, const char *str, const char *code, int c) {
	switch (code[0] + code[1]) {
		case 'c'+'0':
			printf(fd, "   %d %s", c, str);
			break;
		case 'd'+'0':
			if (c > 1) printf(fd, "%s", str);
			break;
		default:
			printf(fd, "%s", str);
	}
}

void uniq(int fd, char *code) {
	int n, i, j = 0, cols = 0, ln = 0, c = 0, opt = (code[2] == 'i' ? 1 : 0);
	char buf[MAX_SIZE], oStr[MAX_SIZE*5/2], nStr[MAX_SIZE*5/2];
	int (*strcmp_ptr[])(const char*, const char*) = {strcmp, strcmp_incase};

	while ((n = read(fd, buf, sizeof(buf))) >= 0) {
		for (i = 0; i < n; i++) {
			nStr[j++] = buf[i];
			if (i == n-1 && buf[i] != '\n') cols += n;

			if (buf[i] == '\n') {
				nStr[j] = '\0'; j = 0; cols = 0; ++ln;

				if (code[0] == 'c' || code[1] == 'd') {
					if (ln == 1) strcpy(oStr, nStr);
					if ((*strcmp_ptr[opt])(oStr, nStr) != 0) {
						print_mods(stdout, oStr, code, c);
						strcpy(oStr, nStr); c = 1;
					} else ++c;
				} else {
					if (ln == 1 || (*strcmp_ptr[opt])(oStr, nStr) != 0) {
						strcpy(oStr, nStr);
						print_mods(stdout, nStr, code, 0);
					}
				}
			}
		}

		if (n == 0) {
			if (cols) {
				nStr[cols] = '\n'; nStr[cols+1] = '\0'; ++ln;

				if (code[0] == 'c' || code[1] == 'd') {
					if (ln == 1) strcpy(oStr, nStr);
					if ((*strcmp_ptr[opt])(oStr, nStr) != 0) {
						print_mods(stdout, oStr, code, c);
						strcpy(oStr, nStr); c = 1;
					} else ++c;
				} else
					if (ln == 1 || (*strcmp_ptr[opt])(oStr, nStr) != 0)
						print_mods(stdout, nStr, code, 0);
			}
			break;
		}
	}

	if ((code[0] == 'c' || code[1] == 'd') && c != 0)
		print_mods(stdout, oStr, code, c);

	if (n < 0) {
  	  	printf(stderr, "uniq: read error\n");
    	exit();
	}
}

int main(int argc, char *argv[]) {
	int i, j, fd = stdin, fn = 0, len;
	char *code = "000", *file; // code fmt: cdi
	
	if (argc > 1) {
	  	for (i = 1; i < argc; i++) {
			if (strchr("-", argv[i][0])) {
				len = strlen(argv[i]);

				for (j = 1; j < len; j++) {
					if (argv[i][j] == 'c' && code[1] == '0')
						code[0] = 'c';
					else if (argv[i][j] == 'd' && code[0] == '0')
						code[1] = 'd';
					else if (argv[i][j] == 'i' || strcmp("--i", argv[i]) == 0)
						code[2] = 'i';
					else {
						if (argv[i][1] != '-')
							printf(
								stderr,
								"uniq: invalid option -- '%c'\n",
								argv[i][j]
							);
						else
							printf(
								stderr,
								"uniq: unrecognized option '%s'\n",
								argv[i]
							);
							
						printf(stdout, "uasge: uniq [-c|-d] [-i] [input]\n");
						exit();
					}
				}
			} else {
				if (fn == 0) {
					file = argv[i]; ++fn;
				} else {
					printf(stderr, "uniq: extra operand '%s'\n", argv[i]);
					printf(stdout, "usage: uniq [-c|-d] [-i] [input]\n");
					exit();
				}
			}
		}
	}
	
	if (file)
		if ((fd = open(file, O_RDONLY)) < 0) {
		  printf(stderr, "uniq: cannot open %s\n", file);
		  exit();
		}

	uniq(fd, code);
	close(fd);
	exit();
}

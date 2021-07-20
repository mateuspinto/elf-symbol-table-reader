#include <fcntl.h>
#include <gelf.h>
#include <libelf.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char **argv) {
  Elf *elf;
  Elf_Scn *scn = NULL;
  GElf_Shdr shdr;
  Elf_Data *data;
  GElf_Sym sym;
  int fd, ii, count;
  long unsigned int iterator_print = 0;

  if (argc == 1) {
    printf("Please input the elf file path in args!\n");
    return 1;
  }

  elf_version(EV_CURRENT);

  fd = open(argv[1], O_RDONLY);
  elf = elf_begin(fd, ELF_C_READ, NULL);

  while ((scn = elf_nextscn(elf, scn)) != NULL) {
    gelf_getshdr(scn, &shdr);
    if (shdr.sh_type == SHT_SYMTAB) {
      /* found a symbol table, go print it. */
      break;
    }
  }

  data = elf_getdata(scn, NULL);
  count = shdr.sh_size / shdr.sh_entsize;

  /* print the symbol names */
  for (ii = 0; ii < count; ++ii) {

    gelf_getsym(data, ii, &sym);

    printf("%lu: ", iterator_print);
    iterator_print++;

    // value
    printf("0x%.8lu", sym.st_value);

    // size
    printf(" 0x%.8lu", sym.st_size);

    // type
    switch (sym.st_info) {
    case 0:
      printf("  NOTY");
      break;
    case 1:
      printf("  OBJT");
      break;
    case 2:
      printf("  FUNC");
      break;
    case 3:
      printf("  SECT");
      break;
    case 4:
      printf("  FILE");
      break;

    default:
      break;
    }

    // bind
    switch (sym.st_info) {
    case 0:
      printf(" LOCL");
      break;
    case 1:
      printf(" GLOB");
      break;
    case 2:
      printf(" WEAK");
      break;
    case 3:
      printf("  NUM");
      break;

    default:
      break;
    }

    // name
    printf(" %s", elf_strptr(elf, shdr.sh_link, sym.st_name));

    printf("\n");
  }
  elf_end(elf);
  close(fd);

  return 0;
}

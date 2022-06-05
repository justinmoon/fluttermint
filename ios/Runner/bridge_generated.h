#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_address(int64_t port_);

void wire_init(int64_t port_, struct wire_uint_8_list *path);

void wire_balance(int64_t port_);

void wire_pegin(int64_t port_, struct wire_uint_8_list *txid);

void wire_pegout(int64_t port_, struct wire_uint_8_list *address);

void wire_pay(int64_t port_, struct wire_uint_8_list *bolt11);

struct wire_uint_8_list *new_uint_8_list(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_address);
    dummy_var ^= ((int64_t) (void*) wire_init);
    dummy_var ^= ((int64_t) (void*) wire_balance);
    dummy_var ^= ((int64_t) (void*) wire_pegin);
    dummy_var ^= ((int64_t) (void*) wire_pegout);
    dummy_var ^= ((int64_t) (void*) wire_pay);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
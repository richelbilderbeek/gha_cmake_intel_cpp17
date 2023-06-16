#include <algorithm>
#include <cassert>
#include <iostream>
#include <numeric>
#include <vector>

std::vector<int> sort_a(std::vector<int> v)
{
 const auto sz = v.size();
  for(auto i = 0u; i != sz - 1; ++i)
  {
    for(auto j = 0u; j != sz - i - 1; ++j)
    {
      if(v[j] > v[j+1])
      {
        std::swap(v[j],v[j+1]);
      }
    }
  }
  return v;
}

std::vector<int> sort_b(std::vector<int> v)
{
  std::sort(std::begin(v), std::end(v));
  return v;
}

auto create_series(const int sz = 100'000)
{
  std::vector<int> v(sz);
  std::iota(std::begin(v), std::end(v), 0);
  std::reverse(std::begin(v), std::end(v));
  return v;
}

int main()
{
  #ifndef NDEBUG
  #error Do not profile in debug mode
  #endif
  assert(!"Do not profile in debug mode");
  static_assert("C++17");

  #ifdef __GNUC__
  // This still is defined :-/
  //#error No GCC in this example please
  #endif

  #ifdef __clang__
  // This still is defined :-/
  //#error No clang in this example please
  #endif

  const auto v = create_series(500'000);
  const auto a = sort_a(v);
  const auto b = sort_b(v);
  if (a != b) return 1;
}

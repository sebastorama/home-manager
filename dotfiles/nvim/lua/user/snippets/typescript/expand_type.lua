local M = [[
export type ExpandRecursively<T> = T extends (...args: infer A) => infer R
  ? (...args: ExpandRecursively<A>) => ExpandRecursively<R>
  : T extends object
  ? T extends infer O
    ? {{ [K in keyof O]: ExpandRecursively<O[K]> }}
    : never
  : T;
]]

return M

// #region Compute UnionToTuple
type Overwrite<T, S extends any> = { [P in keyof T]: S[P] };
type TupleUnshift<T extends any[], X> = T extends any
  ? ((x: X, ...t: T) => void) extends (...t: infer R) => void
    ? R
    : never
  : never;
type TuplePush<T extends any[], X> = T extends any
  ? Overwrite<TupleUnshift<T, any>, T & { [x: string]: X }>
  : never;
type UnionToIntersection<U> = (
  U extends any ? (k: U) => void : never
) extends (k: infer I) => void
  ? I
  : never;
type UnionToOvlds<U> = UnionToIntersection<
  U extends any ? (f: U) => void : never
>;
type PopUnion<U> = UnionToOvlds<U> extends (a: infer A) => void
  ? A
  : never;
type UnionToTupleRecursively<T extends any[], U> = {
  1: T;
  0: PopUnion<U> extends infer SELF
    ? UnionToTupleRecursively<TuplePush<T, SELF>, Exclude<U, SELF>>
    : never;
}[[U] extends [never] ? 1 : 0];
// #endregion

type UnionToTuple<U> = UnionToTupleRecursively<[], U>;

type TupleToUnion<T extends readonly any[]> = T[number];

export default function Tuplify<T extends any[]>(...args: T) {
  return args;
}
export function Objectify<T extends {}>(arg: T) {
  return arg;
}

type OptionalExceptFor<
  T,
  TRequired extends keyof T = keyof T
> = Partial<Pick<T, Exclude<keyof T, TRequired>>> &
  Required<Pick<T, TRequired>>;

type LastInTuple<T extends any[], K extends number = 4> = ((
  ...args: T
) => any) extends (...rest: infer R) => any
  ? T[R['length']]
  : never;

export type {
  UnionToTuple,
  TupleToUnion,
  OptionalExceptFor,
  LastInTuple,
};

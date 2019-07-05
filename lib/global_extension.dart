// run
T krun<T>(T block()) => block();

// repeat
krepeat(int times, void action(int)) {
    for (int i = 0; i < times; i++) {
        action(i);
    }
}

T kalso<T>(T t, void block(T obj)) {
    block(t);
    return t;
}

R klet<T, R>(T t, R block(T obj)) => block(t);

abstract class KMixin<T> {
    T also(void block(T obj)) {
        block(this as T);
        return this as T;
    }

    R let<R>(R block(T obj)) => block(this as T);
    T takeIf(bool block(T obj)) => block(this as T) ? this as T : null;
    T takeUnless(bool block(T obj)) => !block(this as T) ? this as T : null;
}

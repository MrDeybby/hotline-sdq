function argmax(arr) {
    var best_i = 0;
    var best_v = arr[0];

    var len = array_length(arr);
    for (var i = 1; i < len; i++) {
        if (arr[i] > best_v) {
            best_v = arr[i];
            best_i = i;
        }
    }

    return best_i;
}

public class ParallelDotProduct extends Thread {
    private double[] a;
    private double[] b;
    private int startIdx;
    private int endIdx;
    private double partialResult;

    public ParallelDotProduct(double[] a, double[] b, int startIdx, int endIdx) {
        this.a = a;
        this.b = b;
        this.startIdx = startIdx;
        this.endIdx = endIdx;
    }

    @Override
    public void run() {
        for(int i = startIdx; i < endIdx; i++) {
            partialResult += a[i] * b[i];
        }
    }

    public double getPartialResult() {
        return partialResult;
    }

    public static void main(String[] args) throws InterruptedException {
        int n = 1_000_000;
        int m = 4;

        double[] a = new double[n];
        double[] b = new double[n];

        for(int i = 0; i < n; i++) {
            a[i] = i;
            b[i] = i + 1;
        }

        ParallelDotProduct[] threads = new ParallelDotProduct[m];
        int chunkSize = n / m;

        for(int i = 0; i < m; i++) {
            int start = i * chunkSize;
            int end;
            if(i == m - 1) {
                end = n;
            } else {
                end = (i + 1) * chunkSize;
            }

            threads[i] = new ParallelDotProduct(a, b, start, end);
            threads[i].start();
        }

        double result = 0;
        for(int i = 0; i < m; i++) {
            threads[i].join();
            result += threads[i].getPartialResult();
        }

        System.out.println("Dot product = " + result);
    }
}

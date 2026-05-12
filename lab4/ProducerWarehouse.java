import java.util.concurrent.locks.ReentrantLock;

class Warehouse {
    int stock = 0;
    private final ReentrantLock lock = new ReentrantLock();

    public void addProduct() {
        lock.lock();
        try {
            stock++;
        } finally {
            lock.unlock();
        }
    }

    public void removeProduct() {
        lock.lock();
        try {
            stock--;
        } finally {
            lock.unlock();
        }
    }

    public int getStock() {
        lock.lock();
        try {
            return stock;
        } finally {
            lock.unlock();
        }
    }
}

class ProducerThread extends Thread {
    Warehouse warehouse;
    int repetitions;

    public ProducerThread(Warehouse warehouse, int repetitions) {
        this.warehouse = warehouse;
        this.repetitions = repetitions;
    }

    @Override
    public void run() {
        for(int i = 0; i < repetitions; i++) {
            warehouse.addProduct();
        }
    }
}

class ConsumerThread extends Thread {
    Warehouse warehouse;
    int repetitions;

    public ConsumerThread(Warehouse warehouse, int repetitions) {
        this.warehouse = warehouse;
        this.repetitions = repetitions;
    }

    @Override
    public void run() {
        for(int i = 0; i < repetitions; i++) {
            warehouse.removeProduct();
        }
    }
}

public class ProducerWarehouse {
    public static void main(String[] args) throws Exception {
        Warehouse warehouse = new Warehouse();

        ProducerThread p1 = new ProducerThread(warehouse, 100000);
        ProducerThread p2 = new ProducerThread(warehouse, 100000);

        ConsumerThread c1 = new ConsumerThread(warehouse, 100000);
        ConsumerThread c2 = new ConsumerThread(warehouse, 100000);

        p1.start();
        p2.start();
        c1.start();
        c2.start();

        p1.join();
        p2.join();
        c1.join();
        c2.join();

        System.out.println("Final stock = " + warehouse.getStock());
    }
}

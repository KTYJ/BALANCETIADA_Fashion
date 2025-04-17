//    public String orderProdToString() {
//        String name = this.getName();
//        String sku = this.getSku();
//        String size = String.join(",", this.getSize()); // "S,M,L"  
//        String price = String.valueOf(this.getPrice()); //double to str
//
//        // Convert stock array to comma-separated string
//        StringBuilder stockBuilder = new StringBuilder();
//        int[] stock = this.getStock();
//
//        //this should be 1 length
//        for (int i = 0; i < stock.length; i++) {
//            stockBuilder.append(stock[i]);
//            if (i < stock.length - 1) {
//                stockBuilder.append(",");
//            }
//        }
//
//        return name + "|" + sku + "|" + size + "|" + price + "|" + stockBuilder.toString();
//    }
//
//    public static Product strToOrderProd(String orderStrProd) {
//        String[] parts = orderStrProd.split("\\|");
//        if (parts.length != 5) {
//            throw new IllegalArgumentException("Invalid product data format.");
//        }
//            
//        String name = parts[0];
//        String sku = parts[1];
//        String[] size = parts[2].split(","); // "S,M,L" → ["S", "M", "L"]
//        double price = Double.parseDouble(parts[3]);
//
//        String[] stockStrArr = parts[4].split(",");
//        int[] stock = new int[stockStrArr.length];
//        for (int i = 0; i < stockStrArr.length; i++) {
//            stock[i] = Integer.parseInt(stockStrArr[i]);
//        }
//
//        return new Product(name, sku, size, price, stock);
//    } 
//    
//    //eugene
//    public static String prodListToOrderString(ArrayList<Product> products) {
//        ArrayList<String> encodedProducts = new ArrayList<>();
//        for (Product p : products) {
//            encodedProducts.add(p.orderProdToString());
//        }
//        return String.join("#", encodedProducts);
//    }
//
//    //jin han
//    public static ArrayList<Product> orderStrToProdList(String data) {
//        ArrayList<Product> products = new ArrayList<>();
//        String[] productStrs = data.split("#");
//        for (String prodStr : productStrs) {
//            products.add(strToOrderProd(prodStr));
//        }
//        return products;
//    }

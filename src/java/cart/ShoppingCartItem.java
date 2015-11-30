/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package cart;

import entity.OrderedProductColor;
import entity.OrderedProductSize;
import entity.Product;

/**
 *
 * @author tgiunipero
 */
public class ShoppingCartItem {

    Product product;
    short quantity;
    OrderedProductColor orderedProductColor;
    OrderedProductSize orderedProductSize;

    public ShoppingCartItem(Product product, OrderedProductColor orderedProductColor, OrderedProductSize orderedProductSize) {
        this.product = product;
        quantity = 1;
        this.orderedProductColor = orderedProductColor;
        this.orderedProductSize = orderedProductSize;
    }

    public Product getProduct() {
        return product;
    }
    
    public OrderedProductColor getOrderedProductColor() {
        return orderedProductColor;
    }
    
    public void setOrderedProductColor(OrderedProductColor orderedProductColor) {
        this.orderedProductColor = orderedProductColor;
    }
    
    public OrderedProductSize getOrderedProductSize() {
        return orderedProductSize;
    }
    
    public void setOrderedProductSize(OrderedProductSize orderedProductSize) {
        this.orderedProductSize = orderedProductSize;
    }

    public short getQuantity() {
        return quantity;
    }

    public void setQuantity(short quantity) {
        this.quantity = quantity;
    }

    public void incrementQuantity() {
        quantity++;
    }

    public void decrementQuantity() {
        quantity--;
    }

    public double getTotal() {
        double amount = 0;
        amount = (this.getQuantity() * product.getPrice().doubleValue());
        return amount;
    }

}
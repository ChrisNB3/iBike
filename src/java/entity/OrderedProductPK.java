/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Nico
 */
@Embeddable
public class OrderedProductPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "customer_order_id")
    private int customerOrderId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "product_id")
    private int productId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ordered_product_color_id")
    private short orderedProductColorId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ordered_product_size_id")
    private short orderedProductSizeId;

    public OrderedProductPK() {
    }

    public OrderedProductPK(int customerOrderId, int productId, short orderedProductColorId, short orderedProductSizeId) {
        this.customerOrderId = customerOrderId;
        this.productId = productId;
        this.orderedProductColorId = orderedProductColorId;
        this.orderedProductSizeId = orderedProductSizeId;
    }

    public int getCustomerOrderId() {
        return customerOrderId;
    }

    public void setCustomerOrderId(int customerOrderId) {
        this.customerOrderId = customerOrderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public short getOrderedProductColorId() {
        return orderedProductColorId;
    }

    public void setOrderedProductColorId(short orderedProductColorId) {
        this.orderedProductColorId = orderedProductColorId;
    }

    public short getOrderedProductSizeId() {
        return orderedProductSizeId;
    }

    public void setOrderedProductSizeId(short orderedProductSizeId) {
        this.orderedProductSizeId = orderedProductSizeId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) customerOrderId;
        hash += (int) productId;
        hash += (int) orderedProductColorId;
        hash += (int) orderedProductSizeId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderedProductPK)) {
            return false;
        }
        OrderedProductPK other = (OrderedProductPK) object;
        if (this.customerOrderId != other.customerOrderId) {
            return false;
        }
        if (this.productId != other.productId) {
            return false;
        }
        if (this.orderedProductColorId != other.orderedProductColorId) {
            return false;
        }
        if (this.orderedProductSizeId != other.orderedProductSizeId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.OrderedProductPK[ customerOrderId=" + customerOrderId + ", productId=" + productId + ", orderedProductColorId=" + orderedProductColorId + ", orderedProductSizeId=" + orderedProductSizeId + " ]";
    }
    
}

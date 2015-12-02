/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import cart.ShoppingCart;
import cart.ShoppingCartItem;
import entity.Customer;
import entity.CustomerOrder;
import entity.OrderedProduct;
import entity.OrderedProductColor;
import entity.OrderedProductPK;
import entity.OrderedProductSize;
import entity.Product;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Nico
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OrderManager {
   
    @PersistenceContext(unitName = "IBikePU")
    private EntityManager em;
    @Resource
    private SessionContext context;
    @EJB
    private OrderedProductFacade orderedProductFacade;
    @EJB
    private ProductFacade productFacade;
    @EJB
    private CustomerOrderFacade customerOrderFacade;
    @EJB
    private OrderedProductColorFacade orderedProductColorFacade;
    @EJB
    private OrderedProductSizeFacade orderedProductSizeFacade;
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public int placeOrder(String name, String email, String phone, String address, String cityRegion, String ccNumber, ShoppingCart cart) {
        
        try{
            Customer customer = addCustomer(name, email, phone, address, cityRegion, ccNumber);
            CustomerOrder order = addOrder(customer, cart);
            addOrderedItems(order, cart);
            return order.getId();
        } catch (Exception e) {
            context.setRollbackOnly();
            return 0;
        }
    }

    private Customer addCustomer(String name, String email, String phone, String address, String department, String ccNumber) {
        
        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setDepartment(department);
        customer.setCcNumber(ccNumber);

        em.persist(customer);
        return customer;
    }

    private CustomerOrder addOrder(Customer customer, ShoppingCart cart) {
        
        // set up customer order
        CustomerOrder order = new CustomerOrder();
        order.setCustomerId(customer);
        order.setAmount(BigDecimal.valueOf(cart.getTotal()) );
        order.setDelivery(cart.getDelivery() );
        if (cart.getDiscount() == 0.0 )
            order.setDiscount(BigDecimal.ZERO );
        else order.setDiscount(BigDecimal.valueOf(cart.getDiscount()) );

        // create confirmation number
        Random random = new Random();
        int i = random.nextInt(999999999);
        order.setConfirmationNumber(i);

        //try{
            em.persist(order);
        //} catch (ConstraintViolationException cve){
        //    System.err.println(cve.getMessage() );
        //}
        return order;
    }

    private void addOrderedItems(CustomerOrder order, ShoppingCart cart) {

        em.flush();
            
        List<ShoppingCartItem> items = cart.getItems();

        // iterate through shopping cart and create OrderedProducts
        for (ShoppingCartItem scItem : items) {

            int productId = scItem.getProduct().getId();
            short orderedProductColorId = scItem.getOrderedProductColor().getId();
            short orderedProductSizeId = scItem.getOrderedProductSize().getId();

            // set up primary key object
            OrderedProductPK orderedProductPK = new OrderedProductPK();
            orderedProductPK.setCustomerOrderId(order.getId());
            orderedProductPK.setProductId(productId);
            orderedProductPK.setOrderedProductColorId(orderedProductColorId);
            orderedProductPK.setOrderedProductSizeId(orderedProductSizeId);

            // create ordered item using PK object
            OrderedProduct orderedItem = new OrderedProduct(orderedProductPK);

            // set quantity
            orderedItem.setQuantity(scItem.getQuantity());
            
            em.persist(orderedItem);
        }
    }
    
    public Map getOrderDetails(int orderId) {

        Map orderMap = new HashMap();

        // get order
        CustomerOrder order = customerOrderFacade.find(orderId);

        // get customer
        Customer customer = order.getCustomerId();

        // get all ordered products
        List<OrderedProduct> orderedProducts = orderedProductFacade.findByOrderId(orderId);

        // get product details for ordered items
        List<Product> products = new ArrayList<Product>();
        List<OrderedProductColor> orderedProductColors = new ArrayList<OrderedProductColor>();
        List<OrderedProductSize> orderedProductSizes = new ArrayList<OrderedProductSize>();

        for (OrderedProduct op : orderedProducts) {

            Product p = (Product) productFacade.find(op.getOrderedProductPK().getProductId());
            OrderedProductColor c = (OrderedProductColor) orderedProductColorFacade.find(op.getOrderedProductPK().getOrderedProductColorId());
            OrderedProductSize s = (OrderedProductSize) orderedProductSizeFacade.find(op.getOrderedProductPK().getOrderedProductSizeId());
            products.add(p);
            orderedProductColors.add(c);
            orderedProductSizes.add(s);
        }

        // add each item to orderMap
        orderMap.put("orderRecord", order);
        orderMap.put("customer", customer);
        orderMap.put("orderedProducts", orderedProducts);
        orderMap.put("products", products);
        orderMap.put("orderedProductColors", orderedProductColors);
        orderMap.put("orderedProductSizes", orderedProductSizes);

        return orderMap;
    }
}

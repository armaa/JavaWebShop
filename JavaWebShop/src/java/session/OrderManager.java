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
import entity.OrderedProductPK;
import entity.Product;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
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
 * @author office
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OrderManager {
    
    @PersistenceContext(unitName = "JavaWebShopPU")
    private EntityManager em;
    
    @Resource
    private SessionContext context;
    
    @EJB
    private ProductFacade productFacade;
    
    @EJB
    private CustomerOrderFacade customerOrderFacade;
    
    @EJB
    private OrderedProductFacade orderedProductFacade;

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public int placeOrder(String name, String email, String phone, String address, String cityRegion, String creditCard, ShoppingCart cart) {
        try {
            Customer customer = addCustomer(name, email, phone, address, cityRegion, creditCard);
            CustomerOrder order = addCustomerOrder(customer, cart);
            addOrderedItems(order, cart);
            return order.getId();
        } catch (Exception e) {
            context.setRollbackOnly();
            return 0;
        }
        
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

    private Customer addCustomer(String name, String email, String phone, String address, String cityRegion, String creditCard) {
        Customer c = new Customer();
        c.setName(name);
        c.setEmail(email);
        c.setPhone(phone);
        c.setAddress(address);
        c.setCityRegion(cityRegion);
        c.setCcNumber(creditCard);
        
        em.persist(c);
        return c;
    }

    private CustomerOrder addCustomerOrder(Customer customer, ShoppingCart cart) {
        CustomerOrder order = new CustomerOrder();
        order.setCustomer(customer);
        order.setAmount(BigDecimal.valueOf(cart.getTotal()));
        
        order.setDateCreated(new Date());
        
        Random random = new Random();
        order.setConfirmationNumber(random.nextInt(9999999));
        
        em.persist(order);
        return order;
    }

    private void addOrderedItems(CustomerOrder order, ShoppingCart cart) {
        em.flush();
        
        List<ShoppingCartItem> items = cart.getItems();
        
        for (ShoppingCartItem item : items) {
            int productId = item.getProduct().getId();
            
            OrderedProductPK pk = new OrderedProductPK();
            pk.setCustomerOrderId(order.getId());
            pk.setProductId(productId);
            
            OrderedProduct orderedItem = new OrderedProduct(pk);
            
            orderedItem.setQuantity(item.getQuantity());
            
            em.persist(orderedItem);
        }
    }
    
    public Map getOrderDetails(int orderId) {

        Map orderMap = new HashMap();

        // get order
        CustomerOrder order = customerOrderFacade.find(orderId);

        // get customer
        Customer customer = order.getCustomer();

        // get all ordered products
        List<OrderedProduct> orderedProducts = orderedProductFacade.findByOrderId(orderId);

        // get product details for ordered items
        List<Product> products = new ArrayList<>();

        for (OrderedProduct op : orderedProducts) {

            Product p = (Product) productFacade.find(op.getOrderedProductPK().getProductId());
            products.add(p);
        }

        // add each item to orderMap
        orderMap.put("orderRecord", order);
        orderMap.put("customer", customer);
        orderMap.put("orderedProducts", orderedProducts);
        orderMap.put("products", products);

        return orderMap;
    }
}

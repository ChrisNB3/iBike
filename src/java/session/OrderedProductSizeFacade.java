/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.OrderedProductSize;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Nico
 */
@Stateless
public class OrderedProductSizeFacade extends AbstractFacade<OrderedProductSize> {
    @PersistenceContext(unitName = "IBikePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderedProductSizeFacade() {
        super(OrderedProductSize.class);
    }
    
}

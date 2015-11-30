/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.OrderedProductColor;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Nico
 */
@Stateless
public class OrderedProductColorFacade extends AbstractFacade<OrderedProductColor> {
    @PersistenceContext(unitName = "IBikePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderedProductColorFacade() {
        super(OrderedProductColor.class);
    }
    
}

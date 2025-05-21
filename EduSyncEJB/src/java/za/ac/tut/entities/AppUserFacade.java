/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.tut.entities;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.*;

@Stateless
public class AppUserFacade implements AppUserFacadeLocal {

    @PersistenceContext(unitName = "YourPU")
    private EntityManager em;

    @Override
    public void create(AppUser user) {
        em.persist(user);
    }

    @Override
    public AppUser findByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM AppUser u WHERE u.email = :email", AppUser.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<AppUser> findAll() {
        return em.createQuery("SELECT u FROM AppUser u", AppUser.class).getResultList();
    }
}

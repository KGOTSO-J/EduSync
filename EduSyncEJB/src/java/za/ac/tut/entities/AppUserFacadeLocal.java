/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.tut.entities;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author jonas
 */
@Local
public interface AppUserFacadeLocal {
    void create(AppUser user);
    AppUser findByEmail(String email);
    List<AppUser> findAll();
}

 


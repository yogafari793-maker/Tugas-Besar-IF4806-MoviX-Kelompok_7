/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public class Admin extends Pengguna {

    public Admin(int id, String username, String password, String nama) {
        super(id, username, password, nama);
    }

    @Override
    public String getRole() {
        return "Admin";
    }
}

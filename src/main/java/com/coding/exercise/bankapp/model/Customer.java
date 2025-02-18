package com.coding.exercise.bankapp.model;

import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "customer_seq")
    @SequenceGenerator(name = "customer_seq", sequenceName = "CUSTOMER_SEQ", allocationSize = 1)
    @Column(name = "CUST_ID")
    private Long id;

    private String firstName;
    private String lastName;
    private String middleName;
    private Long customerNumber;
    private String status;

    @ManyToOne(cascade = CascadeType.ALL)
    private Address customerAddress;

    @OneToOne(cascade = CascadeType.ALL)
    private Contact contactDetails;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private List<Account> accounts;

    @Temporal(TemporalType.TIME)
    private Date createDateTime;

    @Temporal(TemporalType.TIME)
    private Date updateDateTime;
}
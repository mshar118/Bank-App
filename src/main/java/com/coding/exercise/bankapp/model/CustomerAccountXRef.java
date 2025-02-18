package com.coding.exercise.bankapp.model;

import java.util.UUID;

import jakarta.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CustomerAccountXRef {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="CUST_ACC_XREF_ID")
	private UUID id;
	
	private Long accountNumber;
	
	private Long customerNumber;
	
}

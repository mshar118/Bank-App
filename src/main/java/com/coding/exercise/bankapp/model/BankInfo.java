package com.coding.exercise.bankapp.model;

import java.util.UUID;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
public class BankInfo {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BANK_ID")
	private UUID id;
	
	private String branchName;
	
	private Integer branchCode;
	
	@OneToOne(cascade=CascadeType.ALL)
	private Address branchAddress;
	
	private Integer routingNumber;
	
}

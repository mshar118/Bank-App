package com.coding.exercise.bankapp.model;

import java.util.Date;
import java.util.UUID;

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
public class Transaction {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="TX_ID")
	private UUID id;
	
	private Long accountNumber;
	
	@Temporal(TemporalType.TIME)
	private Date txDateTime;
	
	private String txType;
	
	private Double txAmount;
}

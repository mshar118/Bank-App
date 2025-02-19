package com.coding.exercise.bankapp.domain;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class CustomerDetails {
    private Long id;

   
    private String firstName;

    
    private String lastName;

    private String middleName;

    // @Pattern(regexp = "^\\d{10}$", message = "Work phone must be exactly 10
    // digits")
    private Long customerNumber;

    private String status;

    private AddressDetails customerAddress;

  
    private ContactDetails contactDetails;

}

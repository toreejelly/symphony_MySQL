package kr.co.symphony.pay;

import java.util.ArrayList;

public class PayListDTO {

	private ArrayList<PayDTO> dtos;

	public ArrayList<PayDTO> getDtos() {
		return dtos;
	}

	public void setDtos(ArrayList<PayDTO> dtos) {
		this.dtos = dtos;
	}
	
	@Override
	public String toString() {
		return "PayListDTO [dtos=" + dtos + ", getDtos()=" + getDtos() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	
}

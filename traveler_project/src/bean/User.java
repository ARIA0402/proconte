package bean;

public class User implements java.io.Serializable {
	private int id;
	private int customerid;
	private String name;
	private int postcode;
	private String address;
	private int phonenumber;

	public int getId() {
		return id;
	}
	public int getCustomerId() {
		return customerid;
	}
	public String getName() {
		return name;
	}
	public int getPostCode() {
		return postcode;
	}
	public String getAddress(){
		return address;
	}
	public int getPhoneNumber(){
		return phonenumber;
	}


	public void setId(int id) {
		this.id=id;
	}
	public void setCustomerId(int customer_id) {
		this.customerid=id;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setPostCode(int postcode) {
		this.postcode=postcode;
	}
	public void setAddress(String address){
		this.address=address;
	}
	public void setPhoneNumber(int phonenumber){
		this.phonenumber=phonenumber;
	}
}

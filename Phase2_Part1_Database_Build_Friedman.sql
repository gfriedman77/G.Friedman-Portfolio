/* Phase 2 - Part 1 - Building the Database */


/* For Individual Completion */
	/* Individual first and last Name: Gabrielle Friedman */


/* SQL to Create Table Name */

    CREATE TABLE zAirport

/* Place SQL below */
    
    ( Airport_Code CHAR(3),
        Airport_Name VARCHAR2(25) NOT NULL,
        Airport_City VARCHAR2(25) NOT NULL,
        Airport_Latitude NUMBER(2,15) NOT NULL,
        Airport_Longitude NUMBER(3,15) NOT NULL,
        Airport_Time_Zone VARCHAR2(25) NOT NULL,
        
    CONSTRAINT     zAirport_PK PRIMARY KEY (Airport_Code));


/* SQL to Create Table Name */

    CREATE TABLE zAircraft

/* Place SQL below */

    ( Aircraft_Code CHAR(3),
        Aircraft_Model VARCHAR2(25) NOT NULL,
        Aircraft_Range NUMBER(5) NOT NULL,
        
    CONSTRAINT  zAircraft_PK PRIMARY KEY (Aircraft_Code));


/* SQL to Create Table Name */

    CREATE TABLE zSeat

/* Place SQL below */

    ( Aircraft_Code CHAR(3) NOT NULL,
      Seat_No CHAR(4) NOT NULL,
        Fare_Class VARCHAR2(8) NOT NULL,
        
    CONSTRAINT zSeat_PK PRIMARY KEY (Aircraft_Code,Seat_No),
    CONSTRAINT zSeat_Aircraft_FK FOREIGN KEY (Aircraft_Code) references zAircraft(Aircraft_Code));


/* SQL to Create Table Name */

    CREATE TABLE zFlight

/* Place SQL below */

 ( Flight_ID NUMBER(7),
        Flight_No CHAR(6) NOT NULL,
        Scheduled_Departure TIMESTAMP NOT NULL,
        Scheduled_Arrival TIMESTAMP NOT NULL,
        Departure_Airport_Code CHAR(3),
        Arrival_Airport_Code CHAR(3),
        Flight_Status VARCHAR2(9) NOT NULL,
        Aircraft_Code CHAR(3),
        Actual_Departure TIMESTAMP NOT NULL,
        Actual_Arrival TIMESTAMP NOT NULL,
        
    CONSTRAINT zFlight_PK PRIMARY KEY (Flight_ID),
    CONSTRAINT zFlight_Departure_Airport_FK FOREIGN KEY (Departure_Airport_Code) references zAirport(Airport_Code),
    CONSTRAINT zFlight_Arrival_Airport_FK FOREIGN KEY (Arrival_Airport_Code) references zAirport(Airport_Code),
    CONSTRAINT zFlight_Aircraft_FK FOREIGN KEY (Aircraft_Code) references zAircraft(Aircraft_Code));
    
    
/* SQL to Create Table Name */

    CREATE TABLE zBooking

/* Place SQL below */

    ( Booking_Reference CHAR(6),
        Booking_Date TIMESTAMP WITH TIME ZONE NOT NULL,
        Booking_Total_Amount NUMBER(6,2) NOT NULL,
        
    CONSTRAINT zBooking_PK PRIMARY KEY (Booking_Reference));


/* SQL to Create Table Name */

    CREATE TABLE zTicket

/* Place SQL below */

    ( Ticket_No CHAR(13),
        Booking_Reference CHAR(6),
        Passenger_Id CHAR(20) NOT NULL,
        
    CONSTRAINT zTicket_PK PRIMARY KEY (Ticket_No),
    CONSTRAINT zTicket_FK FOREIGN KEY (Booking_Reference) references zBooking(Booking_Reference));


/* SQL to Create: Table Name */ 
    CREATE TABLE zTicket_Flight

/* Place SQL below */

 ( Ticket_No CHAR(13),
        Flight_ID NUMBER(7),
        Price_Per_Ticket NUMBER(5,2) NOT NULL,
        
    CONSTRAINT zTicket_Flight_PK PRIMARY KEY (Ticket_No,Flight_ID),
    CONSTRAINT zTicket_Flight_Ticket_FK FOREIGN KEY (Ticket_No) references zTicket(Ticket_No),
    CONSTRAINT zTicket_Flight_Flight_FK FOREIGN KEY (Flight_ID) references zFlight(Flight_ID));


/* SQL to Create: Table Name */ 

    CREATE TABLE zBoarding_Pass

/* Place SQL below */

    ( Ticket_No CHAR(13) UNIQUE,
      Flight_ID NUMBER(7),
        Boarding_No NUMBER(3) NOT NULL,
        Seat_No CHAR(4) NOT NULL,
        
    CONSTRAINT zBoarding_Pass_PK PRIMARY KEY (Ticket_No,Flight_ID),
    CONSTRAINT zBoarding_Pass_Ticket_FK FOREIGN KEY (Ticket_No) references zTicket(Ticket_No));


/* ---------------------*/



/* End of Script */
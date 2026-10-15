-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_shipment_info shipment_info_id_pk
-- Type: CONSTRAINT

-- Name: stn_shipment_info shipment_info_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_shipment_info
    ADD CONSTRAINT shipment_info_id_pk PRIMARY KEY (shipment_id);


--

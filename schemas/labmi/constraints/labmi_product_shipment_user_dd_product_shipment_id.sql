-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_shipment_user dd_product_shipment_id
-- Type: CONSTRAINT

-- Name: labmi_product_shipment_user dd_product_shipment_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_product_shipment_user
    ADD CONSTRAINT dd_product_shipment_id PRIMARY KEY (product_shipment_user_id);


--

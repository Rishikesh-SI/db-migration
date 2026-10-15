-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_shipment_user dd_product_shipment_id
-- Type: CONSTRAINT

-- Name: labmi_v1_product_shipment_user dd_product_shipment_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_product_shipment_user
    ADD CONSTRAINT dd_product_shipment_id PRIMARY KEY (product_shipment_user_id);


--

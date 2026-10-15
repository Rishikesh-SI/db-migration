-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_shipment_user dd_product_shipment_id
-- Type: CONSTRAINT

-- Name: dd_product_shipment_user dd_product_shipment_id; Type: CONSTRAINT; Schema: dd_30_04_24; Owner: -
--

ALTER TABLE ONLY dd_30_04_24.dd_product_shipment_user
    ADD CONSTRAINT dd_product_shipment_id PRIMARY KEY (product_shipment_user_id);


--

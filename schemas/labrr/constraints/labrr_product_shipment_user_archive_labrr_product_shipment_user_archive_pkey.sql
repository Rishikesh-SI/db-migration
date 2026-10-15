-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_shipment_user_archive labrr_product_shipment_user_archive_pkey
-- Type: CONSTRAINT

-- Name: labrr_product_shipment_user_archive labrr_product_shipment_user_archive_pkey; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_product_shipment_user_archive
    ADD CONSTRAINT labrr_product_shipment_user_archive_pkey PRIMARY KEY (product_shipment_user_id);


--

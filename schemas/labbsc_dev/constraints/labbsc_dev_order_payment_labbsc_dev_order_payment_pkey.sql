-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_order_payment labbsc_dev_order_payment_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_order_payment labbsc_dev_order_payment_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_order_payment
    ADD CONSTRAINT labbsc_dev_order_payment_pkey PRIMARY KEY (payment_id);


--

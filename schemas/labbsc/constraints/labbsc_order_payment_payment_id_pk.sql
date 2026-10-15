-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_order_payment payment_id_pk
-- Type: CONSTRAINT

-- Name: labbsc_order_payment payment_id_pk; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_order_payment
    ADD CONSTRAINT payment_id_pk PRIMARY KEY (payment_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labwis_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--

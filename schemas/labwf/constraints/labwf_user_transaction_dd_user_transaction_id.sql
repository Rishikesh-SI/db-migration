-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labwf_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--

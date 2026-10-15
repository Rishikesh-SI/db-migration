-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labmi_v1_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labmi_v1_bkp; Owner: -
--

ALTER TABLE ONLY labmi_v1_bkp.labmi_v1_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--

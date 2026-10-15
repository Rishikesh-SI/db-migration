-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labkxip_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--

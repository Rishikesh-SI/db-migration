-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_user_transaction labrao_user_transaction_id
-- Type: CONSTRAINT

-- Name: labmao_user_transaction labrao_user_transaction_id; Type: CONSTRAINT; Schema: labmao_bkp; Owner: -
--

ALTER TABLE ONLY labmao_bkp.labmao_user_transaction
    ADD CONSTRAINT labrao_user_transaction_id PRIMARY KEY (user_transaction_id);


--

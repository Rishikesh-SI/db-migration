-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_user_transaction tmmimg_upd_user_transaction_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_user_transaction tmmimg_upd_user_transaction_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_user_transaction
    ADD CONSTRAINT tmmimg_upd_user_transaction_id PRIMARY KEY (user_transaction_id);


--

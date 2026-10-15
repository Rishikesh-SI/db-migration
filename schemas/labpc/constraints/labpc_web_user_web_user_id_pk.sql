-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labpc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--

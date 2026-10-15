-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client gpn_client_id_pk
-- Type: CONSTRAINT

-- Name: gpn_client gpn_client_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_client
    ADD CONSTRAINT gpn_client_id_pk PRIMARY KEY (client_id);


--

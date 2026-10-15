-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_journal pk_zeven_user_journal
-- Type: CONSTRAINT

-- Name: zeven_user_journal pk_zeven_user_journal; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_user_journal
    ADD CONSTRAINT pk_zeven_user_journal PRIMARY KEY (journal_id);


--
